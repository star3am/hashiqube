# Nomad

<div align="center">
  <p><strong>A flexible workload orchestrator that enables an organization to easily deploy and manage containerized or legacy applications</strong></p>
</div>

![Nomad Logo](images/nomad-logo.png?raw=true "Nomad Logo")

## 🚀 Introduction

HashiCorp Nomad is a highly available, distributed, data-center aware cluster and application scheduler designed to support the modern datacenter. In this HashiQube DevOps lab, you'll get hands-on experience working with Nomad.

Teams increasingly want to move away from the traditional tight coupling of application and operating system. They need an abstraction layer to help developers and operators work together, and save money with better hardware utilization. HashiCorp Nomad meets this need by providing a flexible workload orchestrator.

[![Introduction to HashiCorp Nomad](images/maxresdefault.jpeg)](https://www.youtube.com/watch?v=s_Fm9UtL4YU)

## 📰 Latest News

- [Nomad 1.7 beta improves Vault and Consul integrations, adds NUMA support](https://www.hashicorp.com/blog/nomad-1-7-improves-vault-and-consul-integrations-adds-numa-support)
- [Nomad 1.6 adds node pools, UX updates, and more](https://www.hashicorp.com/blog/nomad-1-6-adds-node-pools-ux-updates-and-more)
- [Nomad 1.5 adds single sign-on and dynamic node metadata](https://www.hashicorp.com/blog/nomad-1-5-adds-single-sign-on-and-dynamic-node-metadata)
- [Nomad 1.4 Adds Nomad Variables and Updates Service Discovery](https://www.hashicorp.com/blog/nomad-1-4-adds-nomad-variables-and-updates-service-discovery)
- [Nomad 1.3 Adds Native Service Discovery and Edge Workload Support](https://www.hashicorp.com/blog/nomad-1-3-adds-native-service-discovery-and-edge-workload-support)

## 🛠️ Provision

Choose one of the following methods to set up your environment:

<!-- tabs:start -->

### **Github Codespace**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash consul/consul.sh
bash nomad/nomad.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docker,docsify,consul,nomad
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash consul/consul.sh
bash nomad/nomad.sh
```
<!-- tabs:end -->

After provisioning, you will have access to the Nomad UI:

![Nomad UI](images/nomad.png?raw=true "Nomad UI")

## 🧩 Nomad Provisioner

The `nomad.sh` script handles the installation and configuration of Nomad:

```bash
# Nomad provisioning script content
[filename](nomad.sh ':include :type=code')
```

## 📊 Monitoring Nomad

We use Prometheus and Grafana to monitor Nomad deployments.

> 💡 For more information, see: [**Monitoring Hashicorp Nomad**](prometheus-grafana/README?id=monitoring-hashicorp-nomad)

## 🔄 Traefik on Nomad

![Traefik Logo](images/traefik-logo.png?raw=true "Traefik Logo")

Traefik Proxy now fully integrates with the new Nomad built-in Service Discovery. This first-of-its-kind ingress integration simplifies ingress in HashiCorp Nomad, making it easier than ever to utilize Nomad directly with Traefik Proxy.

Before Nomad 1.3, when using service discovery with Nomad, Traefik Proxy users had to use Hashicorp Consul and Nomad side-by-side to benefit from Traefik Proxy's automatic configuration. Now, Nomad has a simple and straightforward built-in service discovery, improving usability in both test environments and edge deployments.

### Access Traefik

- Dashboard: `http://localhost:8181`
- Load Balancer: `http://localhost:8080/`

![Traefik Dashboard](images/traefik-dashboard.png?raw=true "Traefik Dashboard")

![Traefik Load Balancer](images/traefik-proxy.png?raw=true "Traefik Load Balancer")

### Traefik Nomad Job Configuration

```hcl
# Traefik job configuration
[filename](nomad/jobs/traefik.nomad ':include :type=code hcl')
```

### Testing the Traefik Configuration

The native Service Discovery in Nomad works seamlessly with Traefik. To test it:

```bash
curl -H "Host: whoami.nomad.localhost" http://localhost:8080 -v
```

Sample output:

```bash
*   Trying 127.0.0.1:8080...
* Connected to localhost (127.0.0.1) port 8080 (#0)
> GET / HTTP/1.1
> Host: whoami.nomad.localhost
> User-Agent: curl/7.79.1
> Accept: */*
> 
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Content-Length: 365
< Content-Type: text/plain; charset=utf-8
< Date: Thu, 16 Jun 2022 02:08:56 GMT
< 
Hostname: 86bb7e3d366a
IP: 127.0.0.1
IP: 172.18.0.5
RemoteAddr: 172.18.0.1:51192
GET / HTTP/1.1
Host: whoami.nomad.localhost
User-Agent: curl/7.79.1
Accept: */*
Accept-Encoding: gzip
X-Forwarded-For: 172.17.0.1
X-Forwarded-Host: whoami.nomad.localhost
X-Forwarded-Port: 80
X-Forwarded-Proto: http
X-Forwarded-Server: 5d7dc64220c8
X-Real-Ip: 172.17.0.1

* Connection #0 to host localhost left intact
```

### Traefik Whoami Example Job

```hcl
# Traefik whoami job configuration
[filename](nomad/jobs/traefik-whoami.nomad ':include :type=code hcl')
```

## 🌐 Fabio on Nomad

![Fabio Load Balancer](images/fabio.png?raw=true "Fabio Load Balancer")

[Fabio](https://fabiolb.net) is an HTTP and TCP reverse proxy that configures itself with data from Consul.

Unlike traditional load balancers and reverse proxies that require manual configuration files, Fabio updates its routing table directly from the data stored in Consul as soon as there is a change, without requiring restart or reloading.

When you register a service in Consul, simply add a tag that announces the paths the upstream service accepts (e.g., `urlprefix-/user` or `urlprefix-/order`), and Fabio will do the rest.

### Access Fabio

- Load Balancer: `http://localhost:9999/`
- UI: `http://localhost:9998`

### Fabio Nomad Job Configuration

```hcl
# Fabio job configuration
[filename](nomad/jobs/fabio.nomad ':include :type=code hcl')
```

### Fabio Properties Configuration

```properties
# Fabio properties configuration
[filename](nomad/jobs/fabio.properties ':include :type=code config')
```

## 📚 Resources

- [Nomad Official Website](https://www.nomadproject.io/)
- [Traefik Proxy and Nomad Integration](https://traefik.io/blog/traefik-proxy-fully-integrates-with-hashicorp-nomad/)
- [Traefik Nomad Provider Documentation](https://doc.traefik.io/traefik/v2.8/providers/nomad/)
- [Fabio GitHub Repository](https://github.com/fabiolb/fabio)

[filename](nomad.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')