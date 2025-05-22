# Portainer

<div align="center">
  <p><strong>Making Docker management easy with a powerful container management interface</strong></p>
</div>

![Portainer Logo](images/portainer-logo.png?raw=true "Portainer Logo")

## 🚀 Introduction

In this HashiQube DevOps lab, you will get hands-on experience with Portainer. Portainer provides an intuitive UI that simplifies Docker container management, allowing you to build and manage your Docker environments with ease.

![Portainer Dashboard](images/portainer.png?raw=true "Portainer Dashboard")

## 🛠️ Provision

Choose one of the following methods to set up your environment:

<!-- tabs:start -->

### **Github Codespace**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash portainer/portainer.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docker,docsify,portainer
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash portainer/portainer.sh
```
<!-- tabs:end -->

## 🖥️ Using Portainer

After provisioning, you can access the Portainer interface by opening your browser and navigating to:

**<http://localhost:9333>**

> 💡 If you're accessing Portainer for the first time, you'll need to create an admin account and set up your initial endpoint.

## ⚙️ Portainer Provisioner

The `portainer.sh` script handles the installation and configuration of Portainer:

```bash
[filename](portainer.sh ':include :type=code')
```

## 🔍 Key Features

- **Simple management interface** for Docker containers
- **Dashboard overview** of your container environment
- **Container creation** with an easy-to-use wizard
- **Volume management** for persistent storage
- **Network configuration** for container connectivity
- **Template library** for quick deployments
- **Role-based access control** for team environments
- **Container logs and console access** for troubleshooting

## 📚 Resources

- [Portainer Official Website](https://www.portainer.io/)
- [Portainer Documentation](https://docs.portainer.io/)
- [Portainer Community](https://community.portainer.io/)
- [Portainer GitHub Repository](https://github.com/portainer/portainer)

[filename](portainer.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')
