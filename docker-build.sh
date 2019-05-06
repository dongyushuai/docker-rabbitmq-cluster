TAG="3.7.14"

docker build -t fixiu/rabbitmq-server:$TAG server
docker build -t fixiu/rabbitmq-server-cluster:$TAG server-cluster
