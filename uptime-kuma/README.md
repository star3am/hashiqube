# Uptime Kuma

https://github.com/louislam/uptime-kuma

![Uptime Kuma](images/uptime-kuma-logo.png?raw=true "Uptime Kuma")

Uptime Kuma is an easy-to-use self-hosted monitoring tool.

To get Uptime Kuma running, please do

## Provision

<!-- tabs:start -->
#### **Github Codespaces**
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)
```
bash docker/docker.sh
bash uptime-kuma/uptime-kuma.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docker,docsify,uptime-kuma
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash uptime-kuma/uptime-kuma.sh
```
<!-- tabs:end -->

## Summary

After provision, you can access Kuma on http://localhost:3001 and login with Username: admin and Password: P@ssw0rd

![Uptime Kuma](images/uptime-kuma-dashboard.png?raw=true "Uptime Kuma")

Uptime Kuma also has a status page

![Uptime Kuma](images/uptime-kuma-status-page.png?raw=true "Uptime Kuma")

And you can also view the Check history

![Uptime Kuma](images/uptime-kuma-check-page.png?raw=true "Uptime Kuma")

## Uptime Kuma Vagrant Provisioner

`uptime-kuma.sh`

[filename](uptime-kuma.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')
