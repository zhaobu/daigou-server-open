package txcloud

import (
	"daigou/library/conf"
	"daigou/library/zaplog"
	"fmt"
	"time"

	sts "github.com/tencentyun/qcloud-cos-sts-sdk/go"
)

//https://cloud.tencent.com/document/product/436/31923
var (
	_options *options
)

type GetCredentialIn struct {
	Action   []string `json:"action,omitempty"`
	Effect   string   `json:"effect,omitempty"`
	Resource []string `json:"resource,omitempty"`
}
type options struct {
	Bucket string `json:"bucket"`
	Region string `json:"region"`
}
type GetCredentialOut struct {
	Credentials *sts.Credentials `json:"Credentials,omitempty"`
	ExpiredTime int              `json:"ExpiredTime,omitempty"`
	StartTime   int              `json:"StartTime,omitempty"`
	Options     *options         `json:"options"`
}

func GetCredential(_args *GetCredentialIn) (out *GetCredentialOut, err error) {
	txConf := conf.Conf.TxCloud
	c := sts.NewClient(
		txConf.Sts.SecretID,
		txConf.Sts.SecretKey,
		nil,
	)
	opt := &sts.CredentialOptions{
		DurationSeconds: int64(time.Hour.Seconds()),
		Region:          txConf.Sts.Region,
		Policy: &sts.CredentialPolicy{
			Statement: []sts.CredentialPolicyStatement{
				{
					Action:   _args.Action,
					Effect:   _args.Effect,
					Resource: _args.Resource,
				},
			},
		},
	}
	res, err := c.GetCredential(opt)
	if err != nil {
		zaplog.Errorf("GetCredential err :%s", err)
		return nil, err
	}
	if _options == nil {
		_options = &options{Bucket: fmt.Sprintf("%s-%s", txConf.Sts.Bucket, txConf.AppID), Region: txConf.Sts.Region}
	}
	out = &GetCredentialOut{
		Options:     _options,
		Credentials: res.Credentials,
		ExpiredTime: res.ExpiredTime,
		StartTime:   res.StartTime,
	}
	return
}
