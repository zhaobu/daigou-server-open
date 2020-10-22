package txcloud

import (
	"context"
	"daigou/library/conf"
	"daigou/library/zaplog"
	"fmt"
	"io"
	"io/ioutil"
	"net/http"
	"net/url"
	"strings"

	"github.com/tencentyun/cos-go-sdk-v5"
	sts "github.com/tencentyun/qcloud-cos-sts-sdk/go"
)

const (
	bucketURL = "https://%s-%s.cos.%s.myqcloud.com" //https://testdelete-1253846586.cos.ap-guangzhou.myqcloud.com
)

//初始化客户端
func newClient(_args *sts.Credentials) (out *cos.Client) {
	// 将 examplebucket-1250000000 和 COS_REGION 修改为真实的信息
	u, _ := url.Parse(fmt.Sprintf(bucketURL, conf.Conf.TxCloud.Sts.Bucket, conf.Conf.TxCloud.AppID, conf.Conf.TxCloud.Sts.Region))
	b := &cos.BaseURL{BucketURL: u}
	// 2.临时密钥
	return cos.NewClient(b, &http.Client{
		Transport: &cos.AuthorizationTransport{
			SecretID:     _args.TmpSecretID,
			SecretKey:    _args.TmpSecretKey,
			SessionToken: _args.SessionToken,
			// Transport: &debug.DebugRequestTransport{
			// 	RequestHeader:  true,
			// 	RequestBody:    true,
			// 	ResponseHeader: true,
			// 	ResponseBody:   true,
			// },
		},
	})
}

//创建存储桶
func PutBucket(_args *GetCredentialIn) (err error) {
	res, err := GetCredential(_args)
	if err != nil {
		zaplog.Errorf("PutBucket err :%s", err)
		return err
	}

	c := newClient(res.Credentials)
	opt := &cos.BucketPutOptions{
		XCosACL: "private",
	}
	res1, err1 := c.Bucket.Put(context.Background(), opt)
	if err1 != nil {
		zaplog.Errorf("PutBucket err :%s", err1)
		return err1
	}
	res2, err2 := ioutil.ReadAll(res1.Body)
	if err2 != nil {
		zaplog.Errorf("PutBucket err :%s", err2)
		return err1
	}
	zaplog.Infof("res2=%+v", res2)
	return
}

//查询存储桶列表
func GetService(_args *GetCredentialIn) (err error) {
	res, err := GetCredential(_args)
	if err != nil {
		zaplog.Errorf("GetService err :%s", err)
		return err
	}
	// zaplog.Infof("GetService GetCredential res=%s", utils.Dump(res))

	c := newClient(res.Credentials)
	server, _, err1 := c.Service.Get(context.Background())
	if err1 != nil {
		zaplog.Errorf("GetService err :%s", err1)
		return err1
	}
	zaplog.Infof("Buckets=%+v", server.Buckets)
	return
}

type PutObjectIn struct {
	GetCredentialIn *GetCredentialIn
	Name            string
	FilePath        string
}

//上传对象
func PutObject(_args *PutObjectIn) (err error) {
	res, err := GetCredential(_args.GetCredentialIn)
	if err != nil {
		zaplog.Errorf("PutObject err :%s", err)
		return err
	}
	c := newClient(res.Credentials)
	// 1.通过字符串上传对象
	f := strings.NewReader(_args.FilePath)

	_, err = c.Object.Put(context.Background(), _args.Name, f, nil)
	if err != nil {
		zaplog.Infof("PutObject err:%s", err)
		return
	}
	// 2.通过本地文件上传对象
	_, err = c.Object.PutFromFile(context.Background(), _args.Name, _args.FilePath, nil)
	if err != nil {
		zaplog.Infof("PutObject err:%s", err)
		return
	}
	return
}

//上传对象图片
func PutObjectImg(_args *PutObjectIn, imgReader io.Reader) (err error) {
	res, err := GetCredential(_args.GetCredentialIn)
	if err != nil {
		zaplog.Errorf("PutObject err :%s", err)
		return err
	}
	c := newClient(res.Credentials)

	_, err = c.Object.Put(context.Background(), _args.Name, imgReader, nil)
	if err != nil {
		zaplog.Infof("PutObject err:%s", err)
		return
	}
	return
}

type GetObjectIn struct {
	GetCredentialIn *GetCredentialIn
	Name            string
	Localpath       string
}

//下载对象
func GetObject(_args *GetObjectIn) (err error) {
	res, err := GetCredential(_args.GetCredentialIn)
	if err != nil {
		zaplog.Errorf("GetObject err :%s", err)
		return err
	}
	c := newClient(res.Credentials)
	// 1.通过响应体获取对象
	// resp, err := c.Object.Get(context.Background(), _args.Name, nil)
	// if err != nil {
	// 	zaplog.Infof("GetObject err:%s", err)
	// 	return
	// }
	// res1, err1 := ioutil.ReadAll(resp.Body)
	// if err1 != nil {
	// 	zaplog.Infof("GetObject err:%s", err1)
	// 	return
	// }
	// resp.Body.Close()

	// 2.获取对象到本地文件
	_, err = c.Object.GetToFile(context.Background(), _args.Name, _args.Localpath, nil)
	if err != nil {
		zaplog.Infof("GetObject err:%s", err)
		return
	}
	return
}

type GetBucketIn struct {
	GetCredentialIn *GetCredentialIn
}

//查询对象列表
func GetBucket(_args *GetBucketIn) (err error) {
	res, err := GetCredential(_args.GetCredentialIn)
	if err != nil {
		zaplog.Errorf("GetBucket err :%s", err)
		return err
	}
	c := newClient(res.Credentials)
	opt := &cos.BucketGetOptions{
		MaxKeys: 100,
	}
	v, _, err := c.Bucket.Get(context.Background(), opt)
	if err != nil {
		zaplog.Errorf("GetBucket err :%s", err)
		return err
	}

	for _, c := range v.Contents {
		zaplog.Infof("%s, %d", c.Key, c.Size)
	}
	return
}
