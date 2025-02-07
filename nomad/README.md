# Nomad

![Nomad Logo](images/nomad-logo.png?raw=true "Nomad Logo")

In this HashiQube DevOps lab you will get hands on experience with HashiCorp Nomad.

Nomad is a highly available, distributed, data-center aware cluster and application scheduler designed to support the modern datacenter with support for

Increasingly, teams want to move away from the traditional tight coupling of application and operating system. So they need an abstraction layer to help developers and operators work together, and save money with better hardware utilization. Introducing HashiCorp Nomad.

## Latest News

- [Nomad 1.7 beta improves Vault and Consul integrations, adds NUMA support](https://www.hashicorp.com/blog/nomad-1-7-improves-vault-and-consul-integrations-adds-numa-support)
- [Nomad 1.6 adds node pools, UX updates, and more](https://www.hashicorp.com/blog/nomad-1-6-adds-node-pools-ux-updates-and-more)
- [Nomad 1.5 adds single sign-on and dynamic node metadata](https://www.hashicorp.com/blog/nomad-1-5-adds-single-sign-on-and-dynamic-node-metadata)
- [Nomad 1.4 Adds Nomad Variables and Updates Service Discovery](https://www.hashicorp.com/blog/nomad-1-4-adds-nomad-variables-and-updates-service-discovery)
- [Nomad 1.3 Adds Native Service Discovery and Edge Workload Support](https://www.hashicorp.com/blog/nomad-1-3-adds-native-service-discovery-and-edge-workload-support)

## Introduction

[![Introduction to HashiCorp Nomad](images/maxresdefault.jpeg)](https://www.youtube.com/watch?v=s_Fm9UtL4YU)

## Provision

<!-- tabs:start -->
#### **Github Codespaces**

```
bash hashiqube/basetools.sh
bash docker/docker.sh
bash consul/consul.sh
bash nomad/nomad.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docker,docsify,consul,nomad
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash consul/consul.sh
bash nomad/nomad.sh
```
<!-- tabs:end -->

![Nomad](images/nomad.png?raw=true "Nomad")

## Nomad Provisioner

`nomad.sh`

[filename](nomad.sh ':include :type=code')

## Monitoring Nomad

We use Prometheus and Grafana to Monitor Nomad

See: [__Monitoring Hashicorp Nomad__](prometheus-grafana/README?id=monitoring-hashicorp-nomad)

## Traefik on Nomad
https://traefik.io/blog/traefik-proxy-fully-integrates-with-hashicorp-nomad/ <br />
https://doc.traefik.io/traefik/v2.8/providers/nomad/

![Traefik Logo](images/traefik-logo.png?raw=true "Traefik Logo")

We are thrilled to announce the full integration of the new Nomad built-in Service Discovery with Traefik Proxy. This is a first-of-its-kind ingress integration that simplifies ingress in HashiCorp Nomad. Utilizing Nomad directly with Traefik Proxy has never been so easy!

In early May, Hashicorp announced Nomad Version 1.3. Among other updates, it also includes a nice list of improvements on usability and developer experience. Before this release, when using service discovery with Nomad, Traefik Proxy users had to use Hashicorp Consul and Nomad side-by-side in order to benefit from Traefik Proxy’s famous automatic configuration. Now, Nomad has a simple and straightforward way to use service discovery built-in. This improves direct usability a lot! Not only in simple test environments but also on the edge.

`http://localhost:8080/` and `http://localhost:8181`

![Traefik Load Balancer](images/traefik-dashboard.png?raw=true "Traefik Load Balancer")

![Traefik Load Balancer](images/traefik-proxy.png?raw=true "Traefik Load Balancer")

## Traefik Nomad Job
[filename](nomad/jobs/traefik.nomad ':include :type=code hcl')

`vagrant up --provision-with basetools,docker,docsify,consul,nomad`

The new native Service Discovery in Nomad really does work seamlessly. With this integration, delivering load balancing, dynamic routing configuration, and ingress traffic routing become easier than ever. Check out the Traefik Proxy 2.8 Release Candidate and the Nomad 1.3 release notes.

`curl -H "Host: whoami.nomad.localhost" http://localhost:8080 -v`

```log
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

## Traefik Whoami
[filename](nomad/jobs/traefik-whoami.nomad ':include :type=code hcl')

## Fabio on Nomad
https://github.com/fabiolb/fabio <br />
https://fabiolb.net

Fabio is an HTTP and TCP reverse proxy that configures itself with data from Consul.

Traditional load balancers and reverse proxies need to be configured with a config file. The configuration contains the hostnames and paths the proxy is forwarding to upstream services. This process can be automated with tools like consul-template that generate config files and trigger a reload.

Fabio works differently since it updates its routing table directly from the data stored in Consul as soon as there is a change and without restart or reloading.

When you register a service in Consul all you need to add is a tag that announces the paths the upstream service accepts, e.g. urlprefix-/user or urlprefix-/order and fabio will do the rest.

`http://localhost:9999/` and `http://localhost:9998`

![Fabio Load Balancer](images/fabio.png?raw=true "Fabio Load Balancer")

`vagrant up --provision-with basetools,docker,docsify,consul,nomad`

Fabio runs as a Nomad job, see `nomad/nomad/jobs/fabio.nomad`

Some routes are added via Consul, see `consul/consul.sh`

## Links 

- https://www.nomadproject.io/

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')

## Fabio Nomad Job
[filename](nomad/jobs/fabio.nomad ':include :type=code hcl')

## Fabio Properties
[filename](nomad/jobs/fabio.properties ':include :type=code config')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')