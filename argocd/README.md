# Argocd

![Argocd Logo](images/argocd-logo.png?raw=true "Argocd Logo")

Argo CD is a declarative, GitOps continuous delivery tool for Kubernetes.

## Why Argo CD?

Application definitions, configurations, and environments should be declarative and version controlled. Application deployment and lifecycle management should be automated, auditable, and easy to understand.

![Argocd UI](images/argocd-ui.webp?raw=true "Argocd UI")

## How it works? 

Argo CD follows the GitOps pattern of using Git repositories as the source of truth for defining the desired application state. Kubernetes manifests can be specified in several ways:

- kustomize applications
- helm charts
- jsonnet files
- Plain directory of YAML/json manifests
- Any custom config management tool configured as a config management plugin

Argo CD automates the deployment of the desired application states in the specified target environments. Application deployments can track updates to branches, tags, or pinned to a specific version of manifests at a Git commit. See tracking strategies for additional details about the different tracking strategies available.

## Provision

<!-- tabs:start -->
#### **Github Codespaces**
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)
```
bash docker/docker.sh
bash minikube/minikube.sh
bash argocd/argocd.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docsify,docker,minikube,argocd
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash minikube/minikube.sh
bash argocd/argocd.sh
```
<!-- tabs:end -->

## Links 

- https://argo-cd.readthedocs.io/en/stable/operator-manual/installation/
- https://devopscube.com/setup-argo-cd-using-helm/

## Provisioner

`argocd.sh`

[filename](argocd.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')