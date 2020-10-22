package alioss

import (
	"crypto/hmac"
	"crypto/sha1"
	"daigou/library/conf"
	"daigou/library/zaplog"
	"encoding/base64"
	"hash"
	"io"
	"time"

	jsoniter "github.com/json-iterator/go"
)

const (
	base64Table = "123QRSTUabcdVWXYZHijKLAWDCABDstEFGuvwxyzGHIJklmnopqr234560178912"
)

var (
	coder = base64.NewEncoding(base64Table)
)

func base64Encode(src []byte) []byte {
	return []byte(coder.EncodeToString(src))
}

func get_gmt_iso8601(expire_end int64) string {
	var tokenExpire = time.Unix(expire_end, 0).Format("2006-01-02T15:04:05Z")
	return tokenExpire
}

type ConfigStruct struct {
	Expiration string     `json:"expiration"`
	Conditions [][]string `json:"conditions"`
}

type PolicyToken struct {
	AccessKeyId string `json:"accessid"`
	Expire      int64  `json:"expire"`
	Signature   string `json:"signature"`
	Policy      string `json:"policy"`
}

type CallbackParam struct {
	CallbackUrl      string `json:"callbackUrl"`
	CallbackBody     string `json:"callbackBody"`
	CallbackBodyType string `json:"callbackBodyType"`
}

func GetPolicyToken(_upload_dir string) *PolicyToken {
	now := time.Now().Unix()
	expire_end := now + conf.Conf.Alioss.Expire_time
	var tokenExpire = get_gmt_iso8601(expire_end)

	//create post policy json
	var config ConfigStruct
	config.Expiration = tokenExpire
	var condition []string
	condition = append(condition, "starts-with")
	condition = append(condition, "$key")
	condition = append(condition, _upload_dir)
	config.Conditions = append(config.Conditions, condition)

	//calucate signature
	result, err := jsoniter.Marshal(config)
	debyte := base64.StdEncoding.EncodeToString(result)
	h := hmac.New(func() hash.Hash { return sha1.New() }, []byte(conf.Conf.Alioss.AccessKeySecret))
	io.WriteString(h, debyte)
	signedStr := base64.StdEncoding.EncodeToString(h.Sum(nil))
	if err != nil {
		zaplog.Errorf("GetPolicyToken err:%s", err)
	}

	policyToken := &PolicyToken{}
	policyToken.AccessKeyId = conf.Conf.Alioss.AccessKeyId
	policyToken.Expire = expire_end
	policyToken.Signature = string(signedStr)
	policyToken.Policy = string(debyte)
	return policyToken
}
