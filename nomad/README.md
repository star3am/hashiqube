# Nomad

https://www.nomadproject.io/

![Nomad Logo](images/nomad-logo.png?raw=true "Nomad Logo")

Nomad is a highly available, distributed, data-center aware cluster and application scheduler designed to support the modern datacenter with support for

Increasingly, teams want to move away from the traditional tight coupling of application and operating system. So they need an abstraction layer to help developers and operators work together, and save money with better hardware utilization. Introducing HashiCorp Nomad.

[![Introduction to HashiCorp Nomad](images/maxresdefault.jpeg)](https://www.youtube.com/watch?v=s_Fm9UtL4YU)

`vagrant up --provision-with basetools,docker,docsify,consul,nomad`

```log    
Bringing machine 'user.local.dev' up with 'virtualbox' provider...
==> user.local.dev: Checking if box 'ubuntu/xenial64' version '20190918.0.0' is up to date...
==> user.local.dev: A newer version of the box 'ubuntu/xenial64' for provider 'virtualbox' is
==> user.local.dev: available! You currently have version '20190918.0.0'. The latest is version
==> user.local.dev: '20200108.0.0'. Run `vagrant box update` to update.
==> user.local.dev: [vagrant-hostsupdater] Checking for host entries
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: Running provisioner: nomad (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-35617-1o32nkl.sh
    ...
    user.local.dev: ++++ Nomad already installed at /usr/local/bin/nomad
    user.local.dev: ++++ Nomad v0.10.2 (0d2d6e3dc5a171c21f8f31fa117c8a765eb4fc02)
    user.local.dev: ++++ cni-plugins already installed
    user.local.dev: ==> Loaded configuration from /etc/nomad/server.conf
    user.local.dev: ==> Starting Nomad agent...
    user.local.dev: ==> Nomad agent configuration:
    user.local.dev:
    user.local.dev:        Advertise Addrs: HTTP: 10.9.99.10:4646; RPC: 10.9.99.10:4647; Serf: 10.9.99.10:5648
    user.local.dev:             Bind Addrs: HTTP: 0.0.0.0:4646; RPC: 0.0.0.0:4647; Serf: 0.0.0.0:4648
    user.local.dev:                 Client: true
    user.local.dev:              Log Level: DEBUG
    user.local.dev:                 Region: global (DC: dc1)
    user.local.dev:                 Server: true
    user.local.dev:                Version: 0.10.2
    user.local.dev:
    user.local.dev: ==> Nomad agent started! Log data will stream in below:
    ...
    user.local.dev: ==> Evaluation "8d2f35bc" finished with status "complete"
    user.local.dev: + Job: "fabio"
    user.local.dev: + Task Group: "fabio" (1 create)
    user.local.dev:   + Task: "fabio" (forces create)
    user.local.dev: Scheduler dry-run:
    user.local.dev: - All tasks successfully allocated.
    user.local.dev: Job Modify Index: 0
    user.local.dev: To submit the job with version verification run:
    user.local.dev:
    user.local.dev: nomad job run -check-index 0 fabio.nomad
    user.local.dev:
    user.local.dev: When running the job with the check-index flag, the job will only be run if the
    user.local.dev: server side version matches the job modify index returned. If the index has
    user.local.dev: changed, another user has modified the job and the plan's results are
    user.local.dev: potentially invalid.
    user.local.dev: ==> Monitoring evaluation "4f53b332"
    user.local.dev:     Evaluation triggered by job "fabio"
    user.local.dev:     Allocation "636be5f5" created: node "63efd16b", group "fabio"
    user.local.dev:     Evaluation status changed: "pending" -> "complete"
    user.local.dev: ==> Evaluation "4f53b332" finished with status "complete"
    user.local.dev: ++++ Nomad http://localhost:4646
```
![Nomad](images/nomad.png?raw=true "Nomad")

## Nomad Vagrant Provisioner

`nomad.sh`

[filename](nomad.sh ':include :type=code')

## Monitoring Hashicorp Nomad

We use Prometheus and Grafana to Monitor Nomad

See: [__Monitoring Hashicorp Nomad__](prometheus-grafana/README?id=monitoring-hashicorp-nomad)

## Traefik Load Balancer for Nomad
https://traefik.io/blog/traefik-proxy-fully-integrates-with-hashicorp-nomad/ <br />
https://doc.traefik.io/traefik/v2.8/providers/nomad/

![Traefik Logo](images/traefik-logo.png?raw=true "Traefik Logo")

We are thrilled to announce the full integration of the new Nomad built-in Service Discovery with Traefik Proxy. This is a first-of-its-kind ingress integration that simplifies ingress in HashiCorp Nomad. Utilizing Nomad directly with Traefik Proxy has never been so easy!

In early May, Hashicorp announced Nomad Version 1.3. Among other updates, it also includes a nice list of improvements on usability and developer experience. Before this release, when using service discovery with Nomad, Traefik Proxy users had to use Hashicorp Consul and Nomad side-by-side in order to benefit from Traefik Proxy’s famous automatic configuration. Now, Nomad has a simple and straightforward way to use service discovery built-in. This improves direct usability a lot! Not only in simple test environments but also on the edge.

`http://localhost:8080/` and `http://localhost:8181`

![Traefik Load Balancer](images/traefik-dashboard.png?raw=true "Traefik Load Balancer")

![Traefik Load Balancer](images/traefik-proxy.png?raw=true "Traefik Load Balancer")

## Traefik Nomad Job template
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

## Traefik Whoami Nomad Job template
[filename](nomad/jobs/traefik-whoami.nomad ':include :type=code hcl')

## Fabio Load Balancer for Nomad
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

## Fabio Nomad Job template
[filename](nomad/jobs/fabio.nomad ':include :type=code hcl')

## Fabio Properties file
[filename](nomad/jobs/fabio.properties ':include :type=code config')