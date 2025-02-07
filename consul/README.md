# Consul

![Consul Logo](images/consul-logo.png?raw=true "Consul Logo")

In this HashiQube DevOps lab you will get hands on experience with HashiCorp Consul.

Consul is a service networking solution to connect and secure services across any runtime platform and public or private cloud

HashiCorp co-founder and CTO Armon Dadgar gives a whiteboard overview of HashiCorp Consul, a service networking solution to connect, configure, and secure services in dynamic infrastructure.

## Latest News

- [Consul 1.17 GA adds locality-aware routing and multi-port support](https://www.hashicorp.com/blog/consul-1-17-ga-adds-locality-aware-routing-and-multi-port-support)
- [Consul 1.17 beta and HCP Consul Central](https://www.hashicorp.com/blog/announcing-consul-1-17-beta-and-hcp-consul-central)
- [Consul 1.16 enhances service mesh reliability, user experience, and security](https://www.hashicorp.com/blog/consul-1-16-enhances-service-mesh-reliability-user-experience-and-security)
- [Consul 1.15 adds Envoy extensions and enhances Envoy access logging](https://www.hashicorp.com/blog/consul-1-15-adds-envoy-extensions-and-enhances-access-logging)
- [Consul 1.14 GA: Announcing Simplified Service Mesh Deployments](https://www.hashicorp.com/blog/consul-1-14-ga-announcing-simplified-service-mesh-deployments)
- [Consul 1.13 Introduces Cluster Peering](https://www.hashicorp.com/blog/consul-1-13-introduces-cluster-peering)
- [Consul 1.12 Hardens Security on Kubernetes with Vault](https://www.hashicorp.com/blog/consul-1-12-hardens-security-on-kubernetes-with-vault)

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')

## Introduction

[![Introduction to HashiCorp Consul](images/maxresdefault.jpeg)](https://www.youtube.com/watch?v=mxeMdl0KvBI)

For hands-on interactive labs with Consul, visit HashiCorp Learn https://hashi.co/learnconsul 

### Consul DNS
To use Consul as a DNS resolver from your laptop, you can create the following file<br />
`/etc/resolver/consul`
```
nameserver 10.9.99.10
port 8600
```
Now names such as `nomad.service.consul` and `fabio.service.consul` will work

## Provision

<!-- tabs:start -->
#### **Github Codespaces**

```
bash hashiqube/basetools.sh
bash docker/docker.sh
bash consul/consul.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docker,docsify,consul
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash consul/consul.sh
```
<!-- tabs:end -->

![Consul](images/consul.png?raw=true "Consul")

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')

## Links 

- https://www.consul.io/

## Provisioner

`consul.sh`

[filename](consul.sh ':include :type=code')

## Monitoring Consul

We use Prometheus and Grafana to Monitor Consul

See: [__Monitoring Hashicorp Consul__](prometheus-grafana/README?id=monitoring-hashicorp-consul)

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')
