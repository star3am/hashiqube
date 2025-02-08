# Docker

![Docker Logo](images/docker-logo.png?raw=true "Docker Logo")

In this HashiQube DevOps lab you will get hands on experience with Docker. You will be able to practice building a Dockerfile and running a docker container. We will also configure a Docker Daemon with the Docker Registry with Authentication 

https://docs.docker.com/install/linux/docker-ce/ubuntu/

## Provision

<!-- tabs:start -->
#### **Github Codespaces**
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)
```
bash docker/docker.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docsify,docker
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
```
<!-- tabs:end -->

In this section we will show you how to install docker.io on Ubuntu.
We will also build an Apache2.4 container from a Dockerfile and run it and expose it on your host machine via Vagrant port_forward on http://localhost:8889

## Setup

When you run the Provisioner we will be running the bash commands below, but for more information you can look at the contents below.

## Provisioner

`docker.sh`

[filename](docker.sh ':include :type=code')

## Dockerfile

`Dockerfile`

```docker
FROM ubuntu:18.04

# Install dependencies
RUN apt-get update && \
 apt-get -y install apache2

# Install apache and write hello world message
RUN echo 'Hello World!' > /var/www/html/index.html

# Configure apache
RUN echo '. /etc/apache2/envvars' > /root/run_apache.sh && \
 echo 'mkdir -p /var/run/apache2' >> /root/run_apache.sh && \
 echo 'mkdir -p /var/lock/apache2' >> /root/run_apache.sh && \
 echo '/usr/sbin/apache2 -D FOREGROUND' >> /root/run_apache.sh && \
 chmod 755 /root/run_apache.sh

EXPOSE 80

CMD /root/run_apache.sh
```

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')

## Links

- https://www.docker.com/
- https://docs.docker.com/
- https://docs.docker.com/compose/

## Monitoring Docker

We use Prometheus and Grafana to Monitor Docker

See: [__Monitoring Docker__](prometheus-grafana/README?id=monitoring-docker)

## Docker Provisioner

[filename](docker.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')