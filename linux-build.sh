go env -w CGO_ENABLED=0 GOARCH="amd64" GOOS="linux" 
go env -w GOPROXY=https://goproxy.cn,direct

pkill -9 daigouserver
rm bin/daigouserver bin/logs
swag init --output ./swagger --generatedTime=false --markdownFiles=true
go build -o bin/daigouserver main.go