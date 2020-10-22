./linux-build.sh
chmod +x ./bin/daigouserver
cd bin/docker
rm -rf nginx/log/

docker-compose down
docker-compose up -d
