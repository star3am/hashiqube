# Docker

<div align="center">
  <img src="images/docker-logo.png" alt="Docker Logo" width="300px">
  <br><br>
  <p><strong>Containerize applications for faster deployment and scaling</strong></p>
</div>

## 🚀 About

In this HashiQube DevOps lab, you'll get hands-on experience with Docker. You'll learn how to:

- Build a custom Docker image from a Dockerfile
- Run Docker containers
- Configure a Docker daemon with authentication
- Set up a Docker registry

This lab follows the [official Docker installation guide](https://docs.docker.com/install/linux/docker-ce/ubuntu/) for Ubuntu-based systems.

## 📋 Provision

<!-- tabs:start -->

### **Github Codespace**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docsify,docker
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
```
<!-- tabs:end -->

## 📦 What You'll Build

When you run the provisioner, it will:

1. Install Docker on your HashiQube environment
2. Build an Apache 2.4 container from a Dockerfile
3. Run the container and expose it to your host machine
4. Make the container accessible at [http://localhost:8889](http://localhost:8889)

## 🛠️ Dockerfile Walkthrough

Below is the Dockerfile used to build the Apache web server container:

```dockerfile
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

This Dockerfile:

- Uses Ubuntu 18.04 as the base image
- Installs Apache web server
- Creates a simple "Hello World" web page
- Sets up a script to run Apache in the foreground
- Exposes port 80 for web traffic
- Specifies the command to run when the container starts

## 📊 Monitoring Docker

HashiQube includes Prometheus and Grafana for monitoring Docker containers.

For detailed information, see the [Monitoring Docker](prometheus-grafana/README?id=monitoring-docker) guide.

## 🧩 Key Docker Concepts

### Images vs Containers

- **Images**: Read-only templates used to create containers
- **Containers**: Runnable instances of images

### Basic Docker Commands

```bash
# List running containers
docker ps

# List all containers (including stopped ones)
docker ps -a

# List available images
docker images

# Pull an image from Docker Hub
docker pull ubuntu:latest

# Run a container
docker run -d -p 8080:80 --name my-container nginx

# Stop a container
docker stop my-container

# Remove a container
docker rm my-container

# Remove an image
docker rmi nginx
```

## 🔌 Docker Networking

Docker creates isolated networks for containers by default. You can:

- Create custom networks
- Connect containers to multiple networks
- Configure network settings

```bash
# Create a custom network
docker network create my-network

# Run a container connected to the custom network
docker run -d --network=my-network --name my-db postgres

# Connect an existing container to a network
docker network connect my-network my-container
```

## 📦 Docker Volumes

Volumes provide persistent storage for containers:

```bash
# Create a named volume
docker volume create my-data

# Run a container with a volume
docker run -d -v my-data:/data --name my-container ubuntu

# Mount a host directory as a volume
docker run -d -v /host/path:/container/path --name my-container ubuntu
```

## 🔍 Docker Provisioner

The script below automates the setup of Docker in your HashiQube environment:

[filename](docker.sh ':include :type=code')

## 🔗 Additional Resources

- [Docker Official Website](https://www.docker.com/)
- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Docker Hub](https://hub.docker.com/) - Repository for Docker images
- [Docker Best Practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)
- [Docker Cheat Sheet](https://www.docker.com/sites/default/files/d8/2019-09/docker-cheat-sheet.pdf)

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')