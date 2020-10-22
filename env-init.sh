# !bin/bash
pkill -9 daigouserver
# 复制模版文件
rm -rf .vscode bin
cp -r .vscode.template .vscode
cp -r bin.template bin

# 执行`gf-cli swagger` 会在$GOPATH/bin目录下安装swag.exe
./document/gf swagger

# 安装gen工具,用于从db生成struct
# set CGO_ENABLED=0
# go get -u -v github.com/smallnest/gen