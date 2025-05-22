# Minikube

<div align="center">
  <p><strong>Run a single-node Kubernetes cluster for local development and learning</strong></p>
</div>

## 🚀 Introduction

[Minikube](https://kubernetes.io/docs/tasks/tools/install-minikube/) is a tool that runs a single-node Kubernetes cluster in a virtual machine on your personal computer. This HashiQube DevOps lab provides hands-on experience with Minikube, Helm, Helm Dashboard, and Traefik, allowing you to learn and experiment with Kubernetes in a safe, local environment.

## 🛠️ Provision

Choose one of the following methods to provision your environment:

<!-- tabs:start -->

### **Github Codespace**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash minikube/minikube.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docker,docsify,minikube
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash minikube/minikube.sh
```
<!-- tabs:end -->

## 📊 Key Components

### Minikube Dashboard

The Dashboard is a web-based Kubernetes user interface that lets you:

- Deploy containerized applications
- Troubleshoot applications
- Manage cluster resources
- View applications running on your cluster
- Create or modify Kubernetes resources

**Access URL**: <http://localhost:10888/api/v1/namespaces/kubernetes-dashboard/services/http:kubernetes-dashboard:/proxy/#/overview?namespace=kubernetes-dashboard>

![Minikube Dashboard](images/minikube.png?raw=true "Minikube Dashboard")

### Kubernetes Pods

Pods are the smallest deployable units of computing that you can create and manage in Kubernetes.

**Key characteristics**:

- Group of one or more containers
- Shared storage and network resources
- Co-located and co-scheduled
- Run in a shared context

![Kubernetes Pods](images/minikube-dashboard-pods.png?raw=true "Kubernetes Pods")

### Kubernetes Services

Services are a method for exposing network applications running as Pods.

**Purpose**:

- Expose Pods to network traffic
- Provide stable networking for dynamic Pods
- Allow frontends to connect to backends without tracking changing IPs

![Kubernetes Services](images/minikube-dashboard-service.png?raw=true "Kubernetes Services")

### Helm Dashboard

![Helm Dashboard](images/helm-dashboard-logo.png?raw=true "Helm Dashboard")

Helm Dashboard is an open-source UI for Helm charts that allows you to:

- View installed Helm charts and their revision history
- See manifest diffs between revisions
- Browse Kubernetes resources created by charts
- Perform rollbacks or upgrades with clear manifest diffs
- Switch between multiple clusters
- Use locally or install into a Kubernetes cluster

**Access URL**: <http://localhost:11888/>

![Helm Dashboard](images/helm-dashboard.png?raw=true "Helm Dashboard")

### K9s CLI

K9s is a terminal-based UI for Kubernetes that wraps kubectl functionality for intuitive cluster interaction.

**To launch K9s**:

```bash
vagrant ssh
k9s
```

![k9s terminal UI](images/k9s_screenshot1.png?raw=true "k9s")

**K9s Tips**:

- Press `0` to display all namespaces
- Press `:` to bring up command prompt
- Navigate with arrow keys and interact using buttons shown in the top right
- Press `l` to show logs of selected pod

For more information, visit the [K9s website](https://k9scli.io/).

### Traefik on Minikube

![Traefik Logo](images/traefik-logo.png?raw=true "Traefik Logo")

Traefik is a modern HTTP reverse proxy and load balancer that can be used as an Ingress controller for Kubernetes.

**Access URLs**:

- Dashboard: <http://localhost:18181/dashboard/>
- Load Balancer: <http://localhost:18080>
- Documentation: <http://localhost:3333/#/minikube/README?id=traefik-on-minikube>

![Traefik on Minikube](images/minikube-traefik-dashboard.png?raw=true "Traefik on Minikube")

## 🧩 kubectl Commands

You can interact with kubectl from your computer using:

```bash
vagrant ssh -c "sudo kubectl command"
```

### Common Command Examples

**Get nodes**:

```bash
vagrant ssh -c "sudo kubectl get nodes"
```

**Get all resources**:

```bash
vagrant ssh -c "kubectl get all -A"
```

or inside HashiQube:

```bash
kubectl get all -A
```

**Get deployments**:

```bash
vagrant ssh -c "sudo kubectl get deployments"
```

**Get services**:

```bash
vagrant ssh -c "sudo kubectl get services"
```

Alternatively, SSH into the VM with `vagrant ssh` and then use `sudo kubectl get nodes`.

## 📚 Resources

- [Minikube Documentation](https://minikube.sigs.k8s.io/docs/start/)
- [Kubernetes Dashboard](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/)
- [Traefik Documentation](https://doc.traefik.io/traefik/v1.7/user-guide/kubernetes/)
- [Helm Dashboard Documentation](https://github.com/komodorio/helm-dashboard)

## 💡 Tips for Using Minikube

1. **Start Simple**: Begin with basic deployments and gradually add complexity
2. **Use the Dashboard**: The Kubernetes Dashboard provides a visual way to understand your cluster
3. **Experiment with Services**: Try different service types (ClusterIP, NodePort, LoadBalancer) to understand networking
4. **Learn kubectl**: Become familiar with common kubectl commands for managing your cluster
5. **Use Namespaces**: Organize your resources into namespaces for better management

[filename](minikube.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')
