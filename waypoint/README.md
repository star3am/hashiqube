# Waypoint

![Waypoint Logo](images/waypoint-logo.png?raw=true "Waypoint Logo")

In this HashiQube DevOps lab you will get hands on experience with HashiCorp Waypoint.

A consistent developer workflow to build, deploy, and release applications across any platform.

Waypoint supports
- aws-ec2
- aws-ecs
- azure-container-instance
- docker
- exec
- google-cloud-run
- kubernetes
- netlify
- nomad
- pack

## Latest News

- [Waypoint 0.11 strengthens Terraform integrations and allows user API access](https://www.hashicorp.com/blog/waypoint-0-11-strengthens-terraform-integrations-and-allows-user-api-access)
- [Waypoint 0.10 Brings Custom Pipelines and Nomad Plugin Updates](https://www.hashicorp.com/blog/waypoint-0-10-brings-custom-pipelines-and-nomad-plugin-updates)
- [Waypoint 0.9 Adds New Runner Commands](https://www.hashicorp.com/blog/waypoint-0-9-adds-new-runner-commands)

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')

## Introduction

In this whiteboard overview, HashiCorp Co-Founder and CTO, Armon Dadgar introduces HashiCorp Waypoint—a project that unifies workflows for build, deploy, and release across platforms. Learn what challenges it is designed to solve and see how it works.

[![Introduction to HashiCorp Waypoint](images/maxresdefault.jpeg)](https://www.youtube.com/watch?v=JL0Qeq4A6So)

https://www.hashicorp.com/blog/announcing-waypoint
https://www.waypointproject.io/

![Hashicorp Waypoint](images/waypoint-workflow.png?raw=true "Hashicorp Waypoint")
![Hashicorp Waypoint](images/waypoint.png?raw=true "Hashicorp Waypoint")
![Hashicorp Waypoint](images/waypoint-nodejs-deployment.png?raw=true "Hashicorp Waypoint")

Waypoint is a wonderful project and it's a firstclass citizen of Hashicorp and runs flawlessly on Nomad. 
To run Waypoint on Nomad do: 

## Waypoint on Nomad

## Provision

<!-- tabs:start -->
#### **Github Codespaces**

```
bash hashiqube/basetools.sh
bash docker/docker.sh
bash nomad/nomad.sh
bash waypoint/waypoint.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docker,nomad,waypoint
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash nomad/nomad.sh
bash waypoint/waypoint.sh
```
<!-- tabs:end -->

Waypoint can also run on Kubernetes and we can test Waypoint using Minikube
To run Waypoint on Kubernetes (Minikube) do: 

## Waypoint on Kubernetes

## Provision

<!-- tabs:start -->
#### **Github Codespaces**

```
bash hashiqube/basetools.sh
bash docker/docker.sh
bash minikube/minikube.sh
bash waypoint-kubernetes-minikube/waypoint-kubernetes-minikube.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docker,docsify,minikube,waypoint-kubernetes-minikube
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash minikube/minikube.sh
bash waypoint-kubernetes-minikube/waypoint-kubernetes-minikube.sh
```
<!-- tabs:end -->

## Waypoint Nomad .hcl 

The following Waypoint job file will deploy our Nomad T-Rex NodeJS Application to Nomad

[filename](waypoint/custom-examples/nomad-trex-nodejs/waypoint.hcl ':include :type=code hcl')

## Waypoint Kubernetes .hcl 

The following Waypoint job file will deploy our Nomad T-Rex NodeJS Application to Kubernetes (Minikube)

[filename](waypoint/custom-examples/kubernetes-trex-nodejs/waypoint.hcl ':include :type=code hcl')

## T-Rex Dockerfile

Both the Nomad and Kubernetes Applications have a similar Dockerfile

```Dockerfile
# syntax=docker/dockerfile:1

FROM node:14.20.0

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN echo "nameserver 10.9.99.10" > /etc/resolv.conf

EXPOSE 6001

CMD [ "node", "index.js" ]
```

## Links

- https://www.waypointproject.io/

## Waypoint Provisioner

`waypoint.sh`

[filename](waypoint.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')
