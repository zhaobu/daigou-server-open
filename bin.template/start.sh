#!/usr/bin/env sh
go env -w GOPROXY=https://goproxy.cn,direct
chmod +x daigouserver
./daigouserver -confPath config/config1.toml
