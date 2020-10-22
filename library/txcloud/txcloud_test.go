package txcloud

import (
	"daigou/library/conf"
	"fmt"
	"testing"
)

func init() {
	conf.InitConfig("../../bin/config/config1.toml")
}

func Test_PutBucket(t *testing.T) {
	PutBucket(&GetCredentialIn{
		Action: []string{
			"name/cos:PutBucket",
		},
		Effect: "allow",
		Resource: []string{
			"qcs::cos:ap-guangzhou:uid/1302455079:daigou-1302455079/",
		},
	})
}

func Test_GetService(t *testing.T) {
	GetService(&GetCredentialIn{
		Action: []string{
			"name/cos:GetService",
		},
		Effect:   "allow",
		Resource: []string{"*"},
	})
}

func Test_PutObject(t *testing.T) {
	for i := 1; i < 4; i++ {
		PutObject(&PutObjectIn{
			GetCredentialIn: &GetCredentialIn{
				Action: []string{
					"name/cos:PutObject",
				},
				Effect:   "allow",
				Resource: []string{"*"},
			},
			Name:     fmt.Sprintf("/system_config/mainpage_scroll_image%d.jpg", i),
			FilePath: fmt.Sprintf("./%d.jpg", i),
		})
	}
}

func Test_GetObject(t *testing.T) {
	GetObject(&GetObjectIn{
		GetCredentialIn: &GetCredentialIn{
			Action: []string{
				"name/cos:GetObject",
			},
			Effect:   "allow",
			Resource: []string{"*"},
		},
		Name:      "/12345/test.jpg",
		Localpath: "./download.jpg",
	})
}

func Test_GetBucket(t *testing.T) {
	GetBucket(&GetBucketIn{
		GetCredentialIn: &GetCredentialIn{
			Action: []string{
				"name/cos:GetBucket",
			},
			Effect:   "allow",
			Resource: []string{"*"},
		},
	})
}
