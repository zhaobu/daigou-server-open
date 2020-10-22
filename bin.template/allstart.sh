#!/usr/bin/env sh
cd ..
./linux-build.sh
cd bin
go env -w GOPROXY=https://goproxy.cn,direct
chmod +x daigouserver
pkill -9 daigouserver
rm -rf nginx/log/ logs
mkdir logs
nohup ./daigouserver -confPath config/config1.toml >> logs/nohup1.log 2>&1 &
nohup ./daigouserver -confPath config/config2.toml >> logs/nohup2.log 2>&1 &
