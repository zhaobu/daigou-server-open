package wxapi

import (
	"bytes"
	"daigou/library/redis"
	"daigou/library/zaplog"
	"flag"
	"image"
	"image/color"
	"image/draw"
	"image/jpeg"
	"io/ioutil"
	"log"
	"unicode/utf8"

	"github.com/golang/freetype"
	"github.com/medivhzhan/weapp/v2"
	"github.com/nfnt/resize"
	"golang.org/x/image/font"
)

const (
	fontSrc string = "../bin/china.ttf" //中文字体库文件路径
)

func GetUnlimited(_arg *weapp.UnlimitedQRCode) (out []byte, err error) {
	accessToken, err := redis.GetAccessToken()
	resp, res, err := _arg.Get(accessToken)
	if err != nil {
		zaplog.Errorf("GetUnlimited err:%s", err)
		return nil, err
	}

	if err = res.GetResponseError(); err != nil {
		// 处理微信返回错误信息\
		zaplog.Errorf("GetUnlimited err:%s", err)
		return
	}
	defer resp.Body.Close()
	out, err = ioutil.ReadAll(resp.Body)
	return
}

// Copyright 2010 The Freetype-Go Authors. All rights reserved.
// Use of this source code is governed by your choice of either the
// FreeType License or the GNU General Public License version 2 (or
// any later version), both of which can be found in the LICENSE file.

//
// This build tag means that "go install github.com/golang/freetype/..."
// doesn't install this example program. Use "go run main.go" to run it or "go
// install -tags=example" to install it.

var (
	dpi      = flag.Float64("dpi", 72, "screen resolution in Dots Per Inch")
	fontfile = flag.String("fontfile", fontSrc, "filename of the ttf font")
	hinting  = flag.String("hinting", "none", "none | full")
	size     = flag.Float64("size", 50, "font size in points")
	spacing  = flag.Float64("spacing", 1.5, "line spacing (e.g. 2 means double spaced)")
	wonb     = flag.Bool("whiteonblack", false, "white text on a black background")
)

var (
	text    = "昵称"
	comment = "扫描我的代购小店，进店选购吧！"
)

//合并生成微信分享图片码
func DrawWeChatCodeShareImg(wcCodeByte []byte, headImgByte []byte, nickName string, welcomeMsg string) (repsData []byte, err error) {
	flag.Parse()
	// Read the font data.
	fontBytes, err := ioutil.ReadFile(*fontfile)
	if err != nil {
		log.Println(err)
		return
	}
	f, err := freetype.ParseFont(fontBytes)
	if err != nil {
		log.Println(err)
		return
	}
	fg, bg := image.Black, image.White
	if *wonb {
		fg, bg = image.White, image.Black
	}

	//初始化一张图片，生成原图
	imgB := bytes.NewReader(wcCodeByte) //小程序码
	img, _ := jpeg.Decode(imgB)

	imgC := bytes.NewReader(headImgByte) //头像
	imgCC, _ := jpeg.Decode(imgC)

	img_bounds := img.Bounds()
	bt := image.Rect(0, 0, img_bounds.Dx()*2, img_bounds.Dy()*2)
	rgba := image.NewRGBA(bt)
	rgba_bounds := rgba.Bounds()
	draw.Draw(rgba, rgba_bounds, bg, image.ZP, draw.Src)
	offset := image.Pt((rgba_bounds.Dx()-img.Bounds().Dx())/2, (rgba_bounds.Dy()-img_bounds.Dy())/2)

	//矩形图片变换为圆形
	min_wide := img_bounds.Dx() //求宽与高的最小值
	if min_wide < img_bounds.Dy() {
		min_wide = img_bounds.Dy()
	}
	draw.DrawMask(rgba, img_bounds.Add(offset), img, image.ZP, &circle{image.Pt(img_bounds.Min.X+img_bounds.Dx()/2, img_bounds.Min.Y+img_bounds.Dy()/2), min_wide / 2}, image.ZP, draw.Over)

	//在图片上添加文字，先设置文字格式
	c := freetype.NewContext()
	c.SetDPI(*dpi)
	//设置字体
	c.SetFont(f)
	//设置大小
	c.SetFontSize(*size)
	//设置边界
	c.SetClip(rgba.Bounds())
	//设置背景底图
	c.SetDst(rgba)
	//设置背景图
	c.SetSrc(fg)
	switch *hinting {
	default:
		c.SetHinting(font.HintingNone)
	case "full":
		c.SetHinting(font.HintingFull)
	}
	//绘制头像
	//头像和昵称之间间隔距离M
	M := int(*size)
	//距离下上界线为Hm
	Hm := int(c.PointToFixed(*size)>>6) * 2
	//缩小版头像
	//缩小到的宽度
	reWide := uint((*size) * (10 / 3)) //圆直径
	_resizeImg := resize.Resize(reWide, 0, imgCC, resize.Lanczos3)
	_res_bounds := _resizeImg.Bounds()
	//绘制到画布上
	offsetC := image.Pt(((rgba_bounds.Dx()-_res_bounds.Dx())/2)-M, Hm-(_res_bounds.Dx()/2))
	draw.DrawMask(rgba, _res_bounds.Add(offsetC), _resizeImg, image.ZP, &circle{image.Pt(_res_bounds.Min.X+_res_bounds.Dx()/2, _res_bounds.Min.Y+_res_bounds.Dy()/2), int(reWide / 2)}, image.ZP, draw.Over)

	//绘制昵称
	pt := freetype.Pt(((rgba_bounds.Dx()-_res_bounds.Dx())/2)+int(reWide/2)+M, Hm)
	if _, err = c.DrawString(nickName, pt); err != nil {
		log.Println(err)
		return
	}

	//绘制欢迎语
	pt1 := freetype.Pt((rgba_bounds.Dx()-int(float64(utf8.RuneCountInString(welcomeMsg))*(*size)))/2, rgba_bounds.Dy()-Hm)
	if _, err = c.DrawString(welcomeMsg, pt1); err != nil {
		log.Println(err)
		return
	}

	// Save that RGBA image to disk.
	bw := bytes.NewBuffer(make([]byte, 0))
	if err = jpeg.Encode(bw, rgba, nil); err != nil {
		return
	}
	repsData = bw.Bytes()

	return
}

//实现圆方法
type circle struct {
	p image.Point
	r int
}

func (c *circle) ColorModel() color.Model {
	return color.AlphaModel
}

func (c *circle) Bounds() image.Rectangle {
	return image.Rect(c.p.X-c.r, c.p.Y-c.r, c.p.X+c.r, c.p.Y+c.r)
}

func (c *circle) At(x, y int) color.Color {
	xx, yy, rr := float64(x-c.p.X)+0.5, float64(y-c.p.Y)+0.5, float64(c.r)
	if xx*xx+yy*yy < rr*rr {
		return color.Alpha{255}
	}
	return color.Alpha{0}
}
