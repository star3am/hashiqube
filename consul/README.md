# HashiCorp Consul

<div align="center">
  <img src="images/consul-logo.png" alt="HashiCorp Consul Logo" width="300px">
  <br><br>
  <p><strong>Connect and secure services across any runtime platform and cloud</strong></p>
</div>

## 🚀 About

In this HashiQube DevOps lab, you'll get hands-on experience with HashiCorp Consul, a service networking solution that connects, configures, and secures services in dynamic infrastructure environments.

<div align="center">
  <a href="https://www.youtube.com/watch?v=mxeMdl0KvBI">
    <img src="images/maxresdefault.jpeg" alt="Introduction to HashiCorp Consul" width="85%">
  </a>
  <p><em>Click the image to watch an introduction to Consul by Armon Dadgar, HashiCorp Co-Founder and CTO</em></p>
</div>

For hands-on interactive labs with Consul, visit [HashiCorp Learn](https://hashi.co/learnconsul).

## 📰 Latest News

- [Consul 1.17 GA adds locality-aware routing and multi-port support](https://www.hashicorp.com/blog/consul-1-17-ga-adds-locality-aware-routing-and-multi-port-support)
- [Consul 1.17 beta and HCP Consul Central](https://www.hashicorp.com/blog/announcing-consul-1-17-beta-and-hcp-consul-central)
- [Consul 1.16 enhances service mesh reliability, user experience, and security](https://www.hashicorp.com/blog/consul-1-16-enhances-service-mesh-reliability-user-experience-and-security)
- [Consul 1.15 adds Envoy extensions and enhances Envoy access logging](https://www.hashicorp.com/blog/consul-1-15-adds-envoy-extensions-and-enhances-access-logging)
- [Consul 1.14 GA: Announcing Simplified Service Mesh Deployments](https://www.hashicorp.com/blog/consul-1-14-ga-announcing-simplified-service-mesh-deployments)
- [Consul 1.13 Introduces Cluster Peering](https://www.hashicorp.com/blog/consul-1-13-introduces-cluster-peering)
- [Consul 1.12 Hardens Security on Kubernetes with Vault](https://www.hashicorp.com/blog/consul-1-12-hardens-security-on-kubernetes-with-vault)

## 📋 Provision

<!-- tabs:start -->

### **Github Codespace**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash consul/consul.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docker,docsify,consul
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash consul/consul.sh
```

<!-- tabs:end -->

## 🖥️ Web UI

After provisioning, you can access the Consul web interface through your browser.

<div align="center">
  <img src="images/consul.png" alt="Consul Web UI" width="85%">
  <p><em>Consul web interface showing services and health status</em></p>
</div>

## 🔍 Key Features

- **Service Discovery** - Register services and discover others with DNS or HTTP
- **Health Checking** - Monitor the health of services to ensure availability
- **Key/Value Store** - Store dynamic configuration in a distributed key-value store
- **Service Mesh** - Secure service-to-service communication with automatic TLS
- **Multi-Datacenter** - Federate multiple Consul clusters across datacenters
- **Service Configuration** - Distribute configuration data to services dynamically

## 🧩 Consul DNS

To use Consul as a DNS resolver from your laptop, create the following file:

**File:** `/etc/resolver/consul`

```bash
nameserver 10.9.99.10
port 8600
```

With this configuration, you can resolve service names like `nomad.service.consul` and `fabio.service.consul` directly from your machine.

## 📊 Monitoring Consul

HashiQube includes Prometheus and Grafana for monitoring Consul.

For detailed information, see the [Monitoring HashiCorp Consul](prometheus-grafana/README?id=monitoring-hashicorp-consul) guide.

## 🛠️ Provisioner Script

The script below automates the setup of Consul in your HashiQube environment:

[filename](consul.sh ':include :type=code')

## 🔗 Additional Resources

- [Consul Official Website](https://www.consul.io/)
- [Consul Documentation](https://www.consul.io/docs)
- [HashiCorp Learn - Consul Tutorials](https://learn.hashicorp.com/consul)
- [Consul API Reference](https://www.consul.io/api-docs)
- [Service Mesh](https://www.consul.io/docs/connect)
- [HashiCorp Developer](https://developer.hashicorp.com/consul)

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')
