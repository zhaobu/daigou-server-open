./linux-build.sh
cd bin
chmod +x ./daigouserver
nohup ./daigouserver >> nohup.log 2>&1 &