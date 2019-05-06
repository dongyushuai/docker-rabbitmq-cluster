TAG="3.7.14"

docker build -t fixiu/rabbitmq-base:$TAG base
docker build -t fixiu/rabbitmq-server:$TAG server
