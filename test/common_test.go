package test

import (
	"daigou/library/utils"
	"testing"
	"time"

	"github.com/gogf/gf/os/gcron"
	"github.com/gogf/gf/os/glog"
)

func TestCommon_Cron(t *testing.T) {
	gcron.AddSingleton("* * * * * *", func() {
		glog.Println("doing")
		time.Sleep(2 * time.Second)
	})
}

func TestCommon_SendSms(t *testing.T) {
	utils.SendSms("*******", "123456", "诚物")
}
