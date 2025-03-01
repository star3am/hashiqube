# Uptime Kuma

<div align="center">
  <p><strong>An easy-to-use self-hosted monitoring tool to track website and service uptime</strong></p>
</div>

![Uptime Kuma](images/uptime-kuma-logo.png?raw=true "Uptime Kuma")

## 🚀 Introduction

[Uptime Kuma](https://github.com/louislam/uptime-kuma) is an easy-to-use self-hosted monitoring tool that allows you to track the availability of your websites and services. With its user-friendly interface, you can quickly set up monitors and receive notifications when your services go down.

## 🛠️ Provision

Choose one of the following methods to set up your environment:

<!-- tabs:start -->

### **Github Codespace**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash uptime-kuma/uptime-kuma.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docker,docsify,uptime-kuma
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash uptime-kuma/uptime-kuma.sh
```
<!-- tabs:end -->

## 📊 Features

After provisioning, you can access Uptime Kuma on <http://localhost:3001> with the following credentials:

- Username: `admin`
- Password: `P@ssw0rd`

### Dashboard

The main dashboard provides an overview of all your monitored services and their current status.

![Uptime Kuma Dashboard](images/uptime-kuma-dashboard.png?raw=true "Uptime Kuma Dashboard")

### Status Page

Uptime Kuma includes a public status page that you can share with users to provide transparency about your service availability.

![Uptime Kuma Status Page](images/uptime-kuma-status-page.png?raw=true "Uptime Kuma Status Page")

### Check History

View detailed history of uptime checks, including response times and availability percentages.

![Uptime Kuma Check History](images/uptime-kuma-check-page.png?raw=true "Uptime Kuma Check History")

## ⚙️ Provisioning Script

The `uptime-kuma.sh` script handles the installation and configuration of Uptime Kuma:

```bash
[filename](uptime-kuma.sh ':include :type=code')
```

## 🔍 Key Capabilities

- **Multiple Monitor Types**: HTTP(S), TCP, Ping, DNS, and more
- **Notifications**: Email, Telegram, Discord, Slack, and many other platforms
- **Status Page**: Public status page to share service status with users
- **History**: Detailed uptime history with graphs and statistics
- **Authentication**: Secure access with username/password protection
- **Mobile-Friendly**: Responsive design that works on mobile devices
- **Low Resource Usage**: Minimal resource requirements for hosting

## 📚 Resources

- [Uptime Kuma GitHub Repository](https://github.com/louislam/uptime-kuma)
- [Uptime Kuma Documentation](https://github.com/louislam/uptime-kuma/wiki)
- [Docker Hub](https://hub.docker.com/r/louislam/uptime-kuma)
