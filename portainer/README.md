# Portainer

![Portainer Logo](images/portainer-logo.png?raw=true "Portainer Logo")

In this HashiQube DevOps lab you will get hands on experience with Portainer.

MAKING DOCKER MANAGEMENT EASY.
Build and manage your Docker environments with ease today.

## Provision

<!-- tabs:start -->
#### **Github Codespaces**
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)
```
bash docker/docker.sh
bash portainer/portainer.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docker,docsify,portainer
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash portainer/portainer.sh
```
<!-- tabs:end -->

## Using Portainer  
Please open http://localhost:9333

## Links

- https://www.portainer.io/

![Portainer](images/portainer.png?raw=true "Portainer")

## Portainer Provisioner

[filename](portainer.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')