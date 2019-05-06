This folder structure contains the Dockerfiles for building RabbitMQ cluster - the number of nodes are completely customizable using [docker-compose](https://docs.docker.com/compose/) `docker-compose.yml` file.


Structure:
==========
There are 3 folders.

1. server - this is the base Dockerfile which builds on a CentOS image and installs the RabbitMQ binaries on the image and has the normal startup command for bring up a RabbitMQ server
2. server-cluster - This builds on the server image and has the cluster startup script for bring up a RabbitMQ server
4. docker-compose - This contains a [docker-compose](https://docs.docker.com/compose/) definition file(docker-compose.yml) for brining up the rabbitmq cluster. Use `docker-compose up -d` to bring up the cluster.



Running the Cluster:
===============================
Once the images are built, boot up the cluster using the `docker-compose.yml` configuration provided in cluster folder:    

`docker-compose up -d`

By default 3 nodes are started up this way:

```yaml
rabbit1:
  image: fixiu/rabbitmq-server:3.7.14
  hostname: rabbit1
  ports:
    - "5672:5672"
    - "15672:15672"
  environment:
    - RABBITMQ_DEFAULT_USER=user
    - RABBITMQ_DEFAULT_PASS=pass
rabbit2:
  image: fixiu/rabbitmq-server:3.7.14
  hostname: rabbit2
  links:
    - rabbit1
  environment: 
   - CLUSTERED=true
   - CLUSTER_WITH=rabbit1
   - RAM_NODE=true

    ports:
      - "5673:5672"
      - "15673:15672"

rabbit3:
  image: fixiu/rabbitmq-server:3.7.14
  hostname: rabbit3
  links:
    - rabbit1
    - rabbit2
  environment: 
   - CLUSTERED=true
   - CLUSTER_WITH=rabbit1   

    ports:
        - "5674:5672"  
```

if needed, additional nodes can be added to this file. If the entire cluster comes up, the management console can be accessed at http://<dockerip>:15672

and connection host should look like this: `dockerip:5672,dockerip:5673,dockerip:5674`