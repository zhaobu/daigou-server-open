$Env:GOOS="linux" 
$Env:GOARCH="amd64"
$Env:CGO_ENABLED=0

if (Test-Path bin/daigouserver){(Remove-Item bin/daigouserver)}

swag init --output ./swagger --generatedTime=false --markdownFiles=true
go build -o bin/daigouserver main.go