package utils

import (
	"fmt"
	"os"

	"github.com/aliyun/alibaba-cloud-sdk-go/services/dysmsapi"
	"github.com/gogf/gf/util/gutil"
	"github.com/sony/sonyflake"

	"daigou/library/conf"
	"daigou/library/zaplog"
)

var flake *sonyflake.Sonyflake

// 判断所给路径是否为文件夹
func IsDir(path string) bool {
	s, err := os.Stat(path)
	if err != nil {
		return false
	}
	return s.IsDir()
}

// 判断所给路径是否为文件
func IsFile(path string) bool {
	return !IsDir(path)
}

func MakeDirs(paths []string) error {
	for _, v := range paths {
		err := os.MkdirAll(v, os.ModePerm)
		if err != nil {
			return err
		}
	}
	return nil
}

func SendSms(mobile, sendStr, signName string) (err error) {
	client, err := dysmsapi.NewClientWithAccessKey("cn-hangzhou", "accessKeyId", "accessKeySecret")

	request := dysmsapi.CreateSendSmsRequest()
	request.Scheme = "https"
	request.PhoneNumbers = mobile
	request.SignName = signName
	request.TemplateCode = "TemplateCode"
	request.TemplateParam = fmt.Sprintf(`{"code":"%s"}`, sendStr)

	response, err := client.SendSms(request)
	if err != nil {
		zaplog.Errorf("client.SendSms err:%s", err)
		return
	}
	zaplog.Debugf("client.SendSms response is %#v\n", response)
	if response.Code != "OK" {
		err = fmt.Errorf(response.Message)
		zaplog.Errorf("client.SendSms err:%s", err)
		return
	}
	return
}

func GenUniqueID() uint64 {
	if flake == nil {
		flake = sonyflake.NewSonyflake(sonyflake.Settings{
			MachineID: func() (uint16, error) {
				if conf.Conf != nil {
					return conf.Conf.Env.ServerID, nil
				}
				return 0, nil
			},
		})
	}
	id, err := flake.NextID()
	if err != nil {
		zaplog.Errorf("flake.NextID() failed with %s", err)
	}
	return id
}

func Dump(v interface{}) string {
	if conf.Conf.Logger.Debug {
		return gutil.Export(v)
	}
	return fmt.Sprintf("%v", v)
}
