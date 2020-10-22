# 复制模版文件
if (Test-Path .vscode) { (Remove-Item -r .vscode) }
if (Test-Path bin) { (Remove-Item -r bin) }

Copy-Item -r .vscode.template .vscode
Copy-Item -r bin.template bin

# 执行`gf-cli swagger` 会在$GOPATH/bin目录下安装swag.exe
./document/gf.exe swagger

# 安装gen工具,用于从db生成struct
# $Env:CGO_ENABLED=0
# go get -u -v github.com/smallnest/gen