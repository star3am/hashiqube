# HashiQube - A DevOps Development Lab Using All the HashiCorp Products

![HashiQube](images/hashiqube-banner.png?raw=true "HashiQube ")

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

## Overview

Hashiqube is the Ultimate Hands-on DevOps Lab in a Docker Container.
It can run in a Github Codespace, locally using Vagrant or Docker Compose, or as a Virtual Machine VM on AWS, GCP and Azure.

Hashiqube has a Docker daemon inside, meaning we can run containers inside Hashiqube using Kubernetes (Minikube), Nomad, or Docker run. It runs all HashiCorp products: [Vault](/vault/?id=vault), [Terraform](/terraform/?id=terraform), [Nomad](/nomad/?id=nomad), [Consul](/consul/?id=consul), [Waypoint](/waypoint/?id=waypoint), [Boundary](/boundary/?id=boundary), [Vagrant](/vagrant/?id=vagrant), [Packer](/packer/?id=packer) and [Sentinel](/sentinel/?id=sentinel).

It also runs other popular Open Source DevOps/DevSecOps applications (Minikube, Ansible AWX Tower, Traefik, etc.) showcasing how simple integration with HashiCorp products can result in tangible learnings and benefits for all users.

Once Hashiqube is up, an internet connection is no longer needed, meaning sales pitches and demos for potential and existing customers are greatly aided.

Hashiqube has been created to help Engineers, Developers and anyone who wants to practice, learn or demo HashiCorp products to get started quickly with a local lab.

Please connect with me on [LinkedIn (Riaan Nolan)](https://www.linkedin.com/in/riaannolan/) or check out [my Credly profile](https://www.credly.com/users/riaan-nolan.e657145c)

---

## Quik Start

<!-- tabs:start -->

### **Github Codespace**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash consul/consul.sh
bash nomad/nomad.sh
bash vault/vault.sh
bash boundary/boundary.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docker,docsify,consul,nomad,vault,boundary
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash consul/consul.sh
bash nomad/nomad.sh
bash vault/vault.sh
bash boundary/boundary.sh
```

<!-- tabs:end -->

---

## Table of Contents

- [HashiQube - A DevOps Development Lab Using All the HashiCorp Products](#hashiqube---a-devops-development-lab-using-all-the-hashicorp-products)
  - [Overview](#overview)
  - [Table of Contents](#table-of-contents)
  - [Running Hashiqube](#running-hashiqube)
    - [Hashiqube Github Codespaces](#hashiqube-github-codespaces)
    - [Hashiqube Local Vagrant](#hashiqube-local-vagrant)
      - [Pre-requisites](#pre-requisites)
      - [Installation Instructions](#installation-instructions)
    - [Docker Compose](#docker-compose)
  - [Documentation and Status](#documentation-and-status)
  - [HashiQube Overview](#hashiqube-overview)
  - [HashiQube Diagrams](#hashiqube-diagrams)
    - [Draw.io Diagram](#drawio-diagram)
  - [Links](#links)
    - [Official Resources](#official-resources)
    - [Articles and Media](#articles-and-media)
  - [Hashiqube Integrations](#hashiqube-integrations)
    - [HashiCorp Products](#hashicorp-products)
    - [Infrastructure \& Orchestration](#infrastructure--orchestration)
    - [Databases](#databases)
    - [Monitoring \& Visualization](#monitoring--visualization)
    - [DevOps Tools](#devops-tools)
  - [HashiQube's Purpose](#hashiqubes-purpose)
  - [Supported Architectures](#supported-architectures)
  - [HashiCorp product Versions](#hashicorp-product-versions)
  - [Components](#components)
    - [Running Individual Components](#running-individual-components)
    - [Running Multiple Components Together](#running-multiple-components-together)
  - [Docker Desktop](#docker-desktop)
    - [Configuration Requirements](#configuration-requirements)
    - [Resource Allocation](#resource-allocation)
  - [Consul DNS](#consul-dns)
  - [The HashiStack](#the-hashistack)
  - [Other](#other)
    - [Service Ports](#service-ports)
  - [Vagrant Basic Usage](#vagrant-basic-usage)
  - [Docker Basic Usage](#docker-basic-usage)
  - [Errors you might encounter](#errors-you-might-encounter)
  - [Support \& Feedback](#support--feedback)
    - [About Hashiqube](#about-hashiqube)
    - [About Me](#about-me)
  - [Contributors](#contributors)
  - [Videos](#videos)

---

## Running Hashiqube

There are several ways to run Hashiqube depending on your needs. The easiest is using Github Codespaces:

| Method | Description | Requirements |
|:-------|:------------|:------------|
| [**Github Codespaces**](#hashiqube-github-codespaces) | Quick start in the cloud (1-minute setup) | Github account only |
| [**Local Vagrant/Docker**](#hashiqube-local-vagrant) | Run locally on your machine | Docker, Vagrant (optional), VirtualBox (optional) |
| [**Hyperscaler VMs**](/multi-cloud/README) | Run on AWS, GCP or Azure | Cloud account |

### Hashiqube Github Codespaces

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

1. Head over to <https://github.com/star3am/hashiqube>
2. Fork the Hashiqube repository
3. In the forked Hashiqube repository in your Github account, launch a new Codespace
4. Watch the video below for follow-along instructions

[![HashiQube on Github's Codespaces](images/hashiqube-on-github-codespace.png)](https://www.youtube.com/watch?v=8uDfDnQZZoA)

### Hashiqube Local Vagrant

Follow the instructions below to run Hashiqube locally on your laptop or PC.

#### Pre-requisites

- **Hardware Requirements:**
  - 10GB of disk space
  - 4G RAM (Minimum) - 8G RAM Recommended
- **Software Requirements:**
  - Docker
  - Vagrant

> :bulb: If you want to run Minikube and a workload like AWX Ansible Tower or Airflow, you need at least 8G RAM. For Gitlab, allocate at least 12G RAM to Docker.

#### Installation Instructions

> :clock3: Duration: 15-30 minutes  
> :bulb: Docker is the default and preferred way to run Hashiqube

1. **Install Docker**: Download from the [Docker desktop installer](https://www.docker.com/products/docker-desktop)
2. **Install Vagrant**: Download from the [Vagrant installer](https://www.vagrantup.com/downloads.html)
3. **Clone the repo**: `git clone https://github.com/star3am/hashiqube.git` - [What is Git?](git/#git)
4. **Start Hashiqube**: Inside the local repo folder, run:

   ```bash
   vagrant up --provision
   ```

   This will set up Vault, Nomad, Consul, Terraform, Localstack and Docker
5. **Access documentation**: Visit <http://localhost:3333>

### Docker Compose

Docker compose is also supported! To bring up Hashiqube with Docker Compose:

1. **Install Docker**: Download from the [Docker desktop installer](https://www.docker.com/products/docker-desktop)
2. **Clone the repo**: `git clone https://github.com/star3am/hashiqube.git`
3. **Start Hashiqube**: Inside the local repo folder, run:

   ```bash
   docker-compose up -d
   ```

4. **Initialize services**:

   ```bash
   # Access the container shell
   docker compose exec hashiqube /bin/bash
   
   # Install dependencies
   bash hashiqube/basetools.sh
   
   # Install Docker daemon
   bash docker/docker.sh
   
   # Start HashiCorp Vault
   bash vault/vault.sh
   ```

To check status:

```bash
docker compose ls
```

Example output:

```bash
NAME                STATUS              CONFIG FILES
hashiqube           running(1)          /Users/riaan/workspace/personal/hashiqube/docker-compose.yml
```

---

## Documentation and Status

After completing the installation steps:

- :book: **Documentation**: <http://localhost:3333>
- :vertical_traffic_light: **Status of Integrations**: <http://localhost:3001>

---

## HashiQube Overview

[![HashiQube: A Jedi DevOps Lab Using All the HashiCorp Products](images/youtube-hashiqube-the-jedi-devops-lab.png)](https://www.youtube.com/watch?v=sFiWzKbpEpU)

---

## HashiQube Diagrams

In essence, Hashiqube is a Docker Container (by default) or a Virtual Machine with a Docker Daemon inside, meaning we can run containers inside Hashiqube using Kubernetes, Nomad, or Docker run.

Hashiqube runs on your local machine or cloud instance and provides:

- All HashiCorp products
- Popular open-source DevOps tools (Minikube, Ansible AWX Tower, etc.)
- Multi-cloud capabilities on AWS, GCP and Azure ([Multi-Cloud](multi-cloud/README))

> Hashiqube is a Training/Development Lab for practice, learning, and demos. It is not designed for production use.

![Diagram](images/hashiqube.drawio.svg)

---

## Links

### Official Resources

- [HashiQube Website](https://hashiqube.com)
- [GitHub Repository](https://github.com/star3am/hashiqube)
- [Terraform Registry Module](https://registry.terraform.io/modules/star3am/hashiqube/hashicorp/latest)

### Articles and Media

- [HashiCorp Blog Post](https://www.hashicorp.com/resources/hashiqube-a-development-lab-using-all-the-hashicorp-products)
- [YouTube Channel](https://www.youtube.com/watch?v=6jGDAGWaFiw)
- [Medium Articles](https://medium.com/search?q=hashiqube)
- [Terraform Development Environment Guide](https://medium.com/@riaan.nolan/top-gun-terraform-development-environment-60ac00d49577)

---

## Hashiqube Integrations

![HashiQube](images/thestack.png?raw=true "HashiQube")

### HashiCorp Products

- [Vault](/vault/#vault) - Secure, store and control access to tokens, passwords, and sensitive data
- [Terraform](/terraform/#terraform) - Infrastructure as Code to provision and manage any cloud or service
- [Consul](/consul/#consul) - Service Mesh connecting applications across environments
- [Nomad](/nomad/#nomad) - Scheduler and orchestrator for containers and applications
- [Boundary](/boundary/#boundary) - Secure remote access to any system from anywhere
- [Waypoint](/waypoint/#waypoint) - Modern workflow for build, deploy, and release across platforms
- [Vagrant](/vagrant/#vagrant) - Build and maintain portable development environments
- [Packer](/packer/#packer) - Create identical machine images for multiple platforms
- [Sentinel](/sentinel/#sentinel) - Embedded policy-as-code framework

### Infrastructure & Orchestration

- [Docker](/docker/#docker) - Container platform
- [Minikube](/minikube/#minikube) - Local Kubernetes cluster
- [Traefik](/nomad/#traefik-load-balancer-for-nomad) - Modern HTTP reverse proxy and load balancer
- [Fabio](/nomad/#fabio-load-balancer-for-nomad) - HTTP/TCP reverse proxy with Consul integration
- [Localstack](/localstack/#localstack) - Local AWS cloud stack

### Databases

- [Oracle MySQL](/database/#oracle-mysql) - Open-source RDBMS
- [Microsoft MSSQL](/database/#microsoft-sql-mssql-express) - Microsoft's RDBMS
- [PostgreSQL](/database/#postgresql) - Advanced open-source RDBMS

### Monitoring & Visualization

- [Prometheus](/prometheus-grafana/#prometheus-and-grafana) - Monitoring system with time series database
- [Grafana](/prometheus-grafana/#prometheus-and-grafana) - Analytics & monitoring solution
- [Elasticsearch](/elasticsearch-kibana-cerebro/#elasticsearch-kibana-and-cerebro) - Search engine
- [Kibana](/elasticsearch-kibana-cerebro/#elasticsearch-kibana-and-cerebro) - Data visualization for Elasticsearch
- [Cerebro](/elasticsearch-kibana-cerebro/#elasticsearch-kibana-and-cerebro) - Elasticsearch admin interface

### DevOps Tools

- [Ansible](/ansible/#ansible) - Infrastructure as code and automation
- [Ansible-Tower](/ansible-tower/#ansible-tower) - Web UI for Ansible
- [Jenkins](/jenkins/#jenkins) - Automation server for CI/CD
- [LDAP](/ldap/#ldap) - Lightweight Directory Access Protocol
- [Dbt](/dbt/#dbt) - Data transformation tool
- [Apache Airflow](/apache-airflow/#apache-airflow) - Workflow management for data pipelines
- [Visual-Studio-Code](/visual-studio-code/#visual-studio-code) - Code editor
- [Portainer](/portainer/#portainer) - Container management UI
- [Gitlab](/gitlab/#gitlab) - DevOps platform
- [Argocd](/argocd/#argocd) - GitOps continuous delivery for Kubernetes
- [Docsify](/docsify/#docsify) - Documentation site generator
- [Mermaid](/mermaid/#mermaid) - Diagram generation from text
- [Newrelic Kubernetes Monitoring](/newrelic-kubernetes-monitoring/#newrelic-kubernetes-monitoring) - Monitor Kubernetes

Once the stack is up, you will have many services running and available on `localhost`.  
For documentation, open <http://localhost:3333> in your browser.

![Hashiqube Integrations](images/logo-qube.png?raw=true "Hashiqube Integrations")

---

## HashiQube's Purpose

Hashiqube enables anyone interested in secure automation pipelines to run a suite of 'best in class' tools locally with minimal system resources.

It empowers users to deploy these tools in a way that covers multiple use cases, providing a 'concept to completion' test bed using open-source HashiCorp products.

The original use case was to demystify DevSecOps using Terraform, Vault, Consul, Sentinel, and Nomad along with other open-source CI/CD tools, demonstrating the value of secret and credential management in software development pipelines.

Thanks to HashiCorp's flexibility, there's no need to wonder how to achieve secure and timely software delivery - just Vagrant up!

---

## Supported Architectures

| Name      | Docker | Virtualbox | Hyper-V |
|:--------- |:------:|:----------:|:-------:|
| amd64     | ✓      | ✓          | ✘       |
| arm64     | ✓      | ✘          | ✘       |
| linux     | ✓      | ✓          | ✘       |
| windows   | ✓      | ✘          | ✘       |
| mac intel | ✓      | ✓          | ✘       |
| mac apple | ✓      | ✘          | ✘       |

---

## HashiCorp product Versions

By default, Hashiqube installs community editions of HashiCorp products, but you can also test and demo Enterprise versions. You can request a trial license from [HashiCorp's website](https://developer.hashicorp.com/vault/tutorials/enterprise/hashicorp-enterprise-license#request-a-trial-license).

To use Enterprise editions, copy the license.hclic into the corresponding product folder and run:

```bash
vagrant up --provision-with basetools,vault,consul,nomad,boundary
```

| Name      | Community | Enterprise |
|:--------- |:---------:|:----------:|
| Vault     | ✓         | ✓          |
| Consul    | ✓         | ✓          |
| Nomad     | ✓         | ✓          |
| Boundary  | ✓         | ✓          |
| Terraform | ✓         | ✘          |

Directory structure example:

```bash
tree -L 1 boundary consul nomad vault

boundary
├── README.md
├── boundary.sh
├── images
└── license.hclic
consul
├── README.md
├── consul.sh
├── images
└── license.hclic
nomad
├── README.md
├── images
├── license.hclic
├── nomad
└── nomad.sh
vault
├── README.md
├── images
├── license.hclic
└── vault.sh
```

---

## Components

Hashiqube is modular - components can be run separately or together.

### Running Individual Components

```bash
vagrant up --provision-with basetools
vagrant up --provision-with docker
vagrant up --provision-with docsify
vagrant up --provision-with vault
vagrant up --provision-with consul
vagrant up --provision-with nomad
vagrant up --provision-with minikube
```

### Running Multiple Components Together

```bash
vagrant up --provision-with basetools,docker,minikube,postgresql,dbt,apache-airflow
```

---

## Docker Desktop

Docker Desktop is an application for Mac/Windows that enables building and sharing containerized applications. It provides a graphical interface for the Docker service.

1. [Download Docker Desktop](https://www.docker.com/products/docker-desktop) and install it
2. Verify installation by opening the Docker Desktop application

![Docker Desktop](images/docker_desktop_installed.png?raw=true "Docker Desktop")

### Configuration Requirements

- Ensure you have the latest version installed
- Keep your operating system updated ([Docker Desktop performance improvements](https://www.docker.com/blog/speed-boost-achievement-unlocked-on-docker-desktop-4-6-for-mac/))

### Resource Allocation

> :bulb: While Hashiqube runs with 4GB (minimum) or 8GB (recommended) RAM, running multiple services simultaneously (Vault, Nomad, Consul, Waypoint, Boundary, Minikube, AWX) requires more resources to avoid contention errors.

![Docker Desktop Resources](images/docker_installed_resources.png?raw=true "Docker Desktop Resources")

- Allocate at least **8GB RAM** to your Docker daemon
- Ensure sufficient disk space is available

---

## Consul DNS

To enable local DNS resolution via Consul, create a file at `/etc/resolver/consul` with:

```bash
nameserver 10.9.99.10
port 8600
```

This enables DNS names like `nomad.service.consul:9999` and `vault.service.consul:9999` via Fabio Load Balancer.

---

## The HashiStack

| Dimension          | Products |                  |                  |
|:------------------ |:-------- |:---------------- |:---------------- |
| **Applications**   | ![Nomad](https://www.datocms-assets.com/2885/1620155098-brandhcnomadprimaryattributedcolor.svg) <br> [**Nomad**](/nomad/#nomad) <br> Scheduler and workload orchestrator | ![Waypoint](https://www.datocms-assets.com/2885/1620155130-brandhcwaypointprimaryattributedcolor.svg) <br> [**Waypoint**](/waypoint/#waypoint) <br> Build, deploy, release workflow | |
| **Networking**     | ![Consul](https://www.datocms-assets.com/2885/1620155090-brandhcconsulprimaryattributedcolor.svg) <br> [**Consul**](/consul/#consul) <br> Service Mesh across any cloud | | |
| **Security**       | ![Boundary](https://www.datocms-assets.com/2885/1620155080-brandhcboundaryprimaryattributedcolor.svg) <br> [**Boundary**](/boundary/#boundary) <br> Secure remote access | ![Vault](https://www.datocms-assets.com/2885/1620159869-brandvaultprimaryattributedcolor.svg) <br> [**Vault**](/vault/#vault) <br> Secrets management | |
| **Infrastructure** | ![Packer](https://www.datocms-assets.com/2885/1620155103-brandhcpackerprimaryattributedcolor.svg) <br> [**Packer**](/packer/#packer) <br> Machine image automation | ![Vagrant](https://www.datocms-assets.com/2885/1620155118-brandhcvagrantprimaryattributedcolor.svg) <br> [**Vagrant**](/vagrant/#vagrant) <br> Development environments | ![Terraform](https://www.datocms-assets.com/2885/1620155113-brandhcterraformprimaryattributedcolor.svg) <br> [**Terraform**](/terraform/#terraform) <br> Infrastructure automation |

---

## Other

### Service Ports

| Service | URL/Port |
|:--------|:---------|
| LDAP | ldap://localhost:389 |
| Localstack web | <http://localhost:8080> |
| DBT web | <http://localhost:28080> |
| Apache Airflow | <http://localhost:18889> |
| Ansible provisioning Apache2 | <http://localhost:8888> |
| Ansible AWX Tower | <http://localhost:8043> |
| Jenkins | <http://localhost:8088> |
| Oracle MySQL | localhost:3306 |
| Microsoft SQL | localhost:1433 |
| Minikube | <http://localhost:10888> |
| Traefik | <http://localhost:8181> |
| Fabio | <http://localhost:9999> |

---

## Vagrant Basic Usage

```bash
# Initial setup with provisioning
vagrant up --provision

# Selective provisioning
vagrant up --provision-with bootstrap|nomad|consul|vault|docker|ldap

# Check VM status
vagrant global-status
vagrant global-status --prune  # Remove stale VMs from cache
vagrant status

# Other common commands
vagrant reload
vagrant up
vagrant destroy
vagrant provision
vagrant plugin list
```

## Docker Basic Usage

```bash
docker image ls
docker ps
docker stop
```

---

## Errors you might encounter

<details>
<summary><strong>Error: Shell provisioner path does not exist</strong></summary>

If you see this error when running `vagrant destroy`:

```bash
hashiqube0: Are you sure you want to destroy the 'hashiqube0' VM? [y/N] y
There are errors in the configuration of this machine. Please fix
the following errors and try again:

shell provisioner:
* `path` for shell provisioner does not exist on the host system: /users/username/workspace/personal/hashiqube/vault/vault.sh
```

**Command to check:** `docker ps`

```bash
CONTAINER ID IMAGE COMMAND CREATED STATUS  PORTS NAMES
1d835d757279   15f77507dce7   "/usr/sbin/init"   38 hours ago   Up 38 hours   0.0.0.0:1433->1433/tcp, 0.0.0.0:3000->3000/tcp, 0.0.0.0:3306->3306/tcp, 0.0.0.0:3333->3333/tcp, 0.0.0.0:4566->4566/tcp, 0.0.0.0:4646-4648->4646-4648/tcp, 0.0.0.0:5001-5002->5001-5002/tcp, 0.0.0.0:5432->5432/tcp, 0.0.0.0:5580->5580/tcp, 0.0.0.0:5601-5602->5601-5602/tcp, 0.0.0.0:7777->7777/tcp, 0.0.0.0:8000->8000/tcp, 0.0.0.0:8043->8043/tcp, 0.0.0.0:8080->8080/tcp, 0.0.0.0:8088->8088/tcp, 0.0.0.0:8181->8181/tcp, 0.0.0.0:8200-8201->8200-8201/tcp, 0.0.0.0:8300-8302->8300-8302/tcp, 0.0.0.0:8500-8502->8500-8502/tcp, 0.0.0.0:8888-8889->8888-8889/tcp, 0.0.0.0:9001-9002->9001-9002/tcp, 0.0.0.0:9011->9011/tcp, 0.0.0.0:9022->9022/tcp, 0.0.0.0:9090->9090/tcp, 0.0.0.0:9093->9093/tcp, 0.0.0.0:9200->9200/tcp, 0.0.0.0:9333->9333/tcp, 0.0.0.0:9701-9702->9701-9702/tcp, 0.0.0.0:9998-9999->9998-9999/tcp, 0.0.0.0:10888->10888/tcp, 0.0.0.0:11888->11888/tcp, 0.0.0.0:18080->18080/tcp, 0.0.0.0:18181->18181/tcp, 0.0.0.0:18888-18889->18888-18889/tcp, 0.0.0.0:19200->19200/tcp, 0.0.0.0:19701-19702->19701-19702/tcp, 0.0.0.0:28080->28080/tcp, 0.0.0.0:31506->31506/tcp, 0.0.0.0:32022->32022/tcp, 0.0.0.0:8600->8600/udp, 0.0.0.0:2255->22/tcp, 0.0.0.0:33389->389/tcp   hashiqube_hashiqube0_1689246032
```

**Solution:** Run `docker stop 1d835d757279` (using your container ID)
</details>

<details>
<summary><strong>Error: IP address not within allowed ranges</strong></summary>

```bash
The IP address configured for the host-only network is not within the
allowed ranges. Please update the address used to be within the allowed
ranges and run the command again.

Address: 10.9.99.10
Ranges: 192.168.56.0/21

Valid ranges can be modified in the /etc/vbox/networks.conf file. For
more information including valid format see:

https://www.virtualbox.org/manual/ch06.html#network_hostonly
```

**Solution:** Create file `/etc/vbox/networks.conf` with:

```bash
* 10.0.0.0/8 192.168.0.0/16
* 2001::/64
```

Then re-run `vagrant up --provision`
</details>

<details>
<summary><strong>Error: Cannot stop container</strong></summary>

When running `vagrant destroy`:

```bash
hashiqube0.service.consul: Are you sure you want to destroy the 'hashiqube0.service.consul' VM? [y/N] y
==> hashiqube0.service.consul: Stopping container...
A Docker command executed by Vagrant didn't complete successfully!
The command run along with the output from the command is shown
below.

Command: ["docker", "stop", "-t", "1", "6c0c8135620ff47efe12df417a0df0e57d7a81a7f7ca06d011323fbb52e573db", {:notify=>[:stdout, :stderr]}]

Stderr: Error response from daemon: cannot stop container: 6c0c8135620ff47efe12df417a0df0e57d7a81a7f7ca06d011323fbb52e573db: tried to kill container, but did not receive an exit event
```

**Solution:** Run `vagrant destroy` again
</details>

<details>
<summary><strong>Error: Port collision</strong></summary>

```bash
Vagrant cannot forward the specified ports on this VM, since they would collide with some other application that is already listening on these ports. The forwarded port to `9200` is already in use on the host machine.

To fix this, modify your current project's Vagrantfile to use another port. For example, where '1234' would be replaced by a unique host port:

config.vm.network :forwarded_port, guest: 9200, host: 1234

Sometimes, Vagrant will attempt to auto-correct this for you. In this case, Vagrant was unable to. This is usually because the guest machine is in a state which doesn't allow modifying port forwarding. You could try 'vagrant reload' (the equivalent of running a halt followed by an up) so vagrant can attempt to auto-correct this upon booting. Be warned that any unsaved work might be lost.
```

**Solution:** Either stop the conflicting service (e.g., Elasticsearch) or modify the Vagrantfile to use a different port:

```bash
# config.vm.network "forwarded_port", guest: 9200, host: 9200 # elasticsearch
```

</details>

---

## Support & Feedback

For suggestions, feedback, and queries, please submit a Pull Request or contact **Riaan Nolan**, creator of HashiQube via [GitHub](https://github.com/star3am/hashiqube).

### About Hashiqube

Hashiqube runs all HashiCorp products and many popular open-source tools used in the industry today.

After running `vagrant up --provision`, you'll have access to:

| Service | URL | Setup Command |
|:--------|:----|:--------------|
| Vault | <http://localhost:8200> | `vagrant up --provision-with basetools,vault` |
| Nomad | <http://localhost:4646> | `vagrant up --provision-with basetools,docker,nomad` |
| Consul | <http://localhost:8500> | `vagrant up --provision-with basetools,consul` |
| Waypoint on Nomad | <https://localhost:9702> | `vagrant up --provision-with basetools,docker,waypoint` |
| Waypoint on Minikube | <https://localhost:19702> | `vagrant up --provision-with basetools,docker,waypoint-kubernetes-minikube` |
| Boundary | <http://localhost:9200> | `vagrant up --provision-with basetools,boundary` |
| Docsify | <http://localhost:3333> | `vagrant up --provision-with basetools,docsify` |

![Hashiqube Integrations](images/logo-qube.png?raw=true "Hashiqube Integrations")

---

### About Me

My name is **Riaan Nolan** and I was born in South Africa. I started as a Web Developer in 2000 and progressed into Systems Administration with a strong focus on Automation, Infrastructure and Configuration as Code.

I have worked for multinational companies in Portugal, Germany, China, South Africa, United States, and Australia.

Please connect with me on [LinkedIn](https://www.linkedin.com/in/riaannolan/) or check out [my Credly profile](https://www.credly.com/users/riaan-nolan.e657145c)

![My Hashicorp Badges](images/hashicorp-badges.png?raw=true "My Hashicorp Badges")

---

## Contributors

A very special mention to HashiQube's contributors. Thank you all for your help, suggestions, and contributions, no matter how small! ❤️

- [Thomas Cockin](https://www.aslantechnology.com.au/)
- [Konstantin Vanyushov](https://www.linkedin.com/in/konstantin-vanyushov/)
- [Tristan Morgan](https://www.linkedin.com/in/tristanmorgan/)
- [Ringo Chan](https://www.linkedin.com/in/ringochan/)
- [Ehsan Mirzaei](https://www.linkedin.com/in/ehsan-mirzaei-54305181/)
- [Greg Luxford](https://www.linkedin.com/in/greg-luxford/)
- [Byron Tuckett](https://www.linkedin.com/in/byrontuckett/)
- [Lane Birmingham](https://www.linkedin.com/in/lane-birmingham-93261b151/)
- [Devang Dhameliya](https://www.linkedin.com/in/devangdhameliya/)
- [Rajesh Cholleti](https://www.linkedin.com/in/rajesh-cholleti-2b25a1116/)
- [Adriana Villela](https://www.linkedin.com/in/adrianavillela/)
- [Charle Van Der Walt](https://linkedin.com/in/charle-van-der-walt-b9ba2628/)
- [JJ Badenhorst](https://github.com/badj)
- [Jan Laubscher](https://howdypress.com/)
- [Nesar Uddin Rahid](https://dribbble.com/rahiddesigner)
- [Ruaan Deysel](https://www.linkedin.com/in/ruaan-deysel/)

---

## Videos

Videos were made with [asciinema](https://asciinema.org/)

```bash
asciinema rec -i 1
asciicast2gif -S 1 -s 2 tmp
```

[google ads](googleads.html ':include :type=iframe width=100% height=300px')