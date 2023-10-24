# HashiQube - A DevOps Development Lab Using All the HashiCorp Products

![HashiQube](images/hashiqube-banner.png?raw=true "HashiQube ")

## Overview

Hashiqube is a DevOps Lab in a Docker Container. Hashiqube has a Docker daemon inside meaning, we can run containers inside Hashiqube using Kubernetes (Minikube) or Nomad or Docker run. It runs all Hashicorp products. [Vault](/vault/?id=vault), [Terraform](/terraform/?id=terraform), [Nomad](/nomad/?id=nomad), [Consul](/consul/?id=consul), [Waypoint](/waypoint/?id=waypoint), [Boundary](/boundary/?id=boundary), [Vagrant](/vagrant/?id=vagrant), [Packer](/packer/?id=packer) and [Sentinel](/sentinel/?id=sentinel).

It also runs a host of other popular Open Source DevOps/DevSecOps applications (Minikube, Ansible AWX Tower, Traefik etc.) showcasing how simple integration with Hashicorp products can result in tangible learnings and benefits for all its users.

Once Hashiqube is up an internet connection is no longer needed meaning sales pitches and demos for potential and existing customers are greatly aided.

Hashiqube has been created to help Engineers, Developers and anyone who wants to practise, learn or demo HashiCorp products to get started quickly with a local lab. 

Please connect with me on [LinkedIn (Riaan Nolan)](https://www.linkedin.com/in/riaannolan/) or check out [my Credly profile](https://www.credly.com/users/riaan-nolan.e657145c)
<br />

## Pre-requisites
* 10GB of disk space and 4G RAM (Minimum) - 8G RAM Recommended
* Docker
* Vagrant

:bulb: If you want to run Minikube and a workload like AWX Ansible Tower, or Airflow you need at least 8G RAM - If you want to run Gitlab as well, you need to give Docker resources at least 12G RAM

## Installation Instructions
:clock3: Duration 15 - 30 minutes <br>
:bulb: Docker is the Default and preferred way to run Hashiqube

* Docker - Download Docker from the [Docker desktop installer](https://www.docker.com/products/docker-desktop) and install
* Vagrant - Download Vagrant from the [Vagrant installer](https://www.vagrantup.com/downloads.html) and install
* Using `git` - clone this repo `git clone s://github.com/star3am/hashiqube.git` - [What is Git?](git/#git)
* Inside the local repo folder, do `vagrant up --provision` - This will set up, Vault, Nomad, Consul, Terraform, Localstack and Docker
* Documentation locally available at http://localhost:3333

## Documentation and Status
:loudspeaker: For Hashiqube Local Documentation and Status after you complete the steps above in [Installation Instructions](/?id=installation-instructions)

:book: Documentation: http://localhost:3333 <br>
:vertical_traffic_light: Status of Integrations: http://localhost:3001

## HashiQube Diagrams

In essence, Hashiqube is a Docker Container (by default) or a Virtual Machine.

Hashiqube has a Docker Daemon inside meaning we can run docker containers/pods inside Hashiqube using Kubernetes or Nomad or Docker run.

Hashiqube runs on your local laptop, PC or a cloud instance.

Hashiqube runs all the Hashicorp products and other popular Open Source tools, such as Minikube, Ansible AWX Tower, Prometheus and Grafana and many, many more, see: [Hashiqube Integrations](/?id=hashiqube-integrations)

You can also run Hashiqube on AWS, GCP and Azure. This is called Hashiqube Multi-Cloud, see: [Multi-Cloud](multi-cloud/README)

Hashiqube is a Training / Development Lab for you to practise, learn or demo POC stuff with, it should not be run in production.

Hashiqube can be visualized with the diagrams below.

![HashiQube Diagram](images/hashiqube-diagram.png?raw=true "HashiQube Diagram")

## Links
* [Hashicorp blog post](https://www.hashicorp.com/resources/hashiqube-a-development-lab-using-all-the-hashicorp-products) <br />
* [Hashiqube Website](https://hashiqube.com) <br />
* [Hashiqube Github](https://github.com/star3am/hashiqube) <br />
* [Hashiqube Youtube](https://www.youtube.com/watch?v=6jGDAGWaFiw) <br />
* [Hashiqube Medium](https://medium.com/search?q=hashiqube) <br />
* [Hashiqube Terraform Registry module](https://registry.terraform.io/modules/star3am/hashiqube/hashicorp/latest) <br />
* [Terraform Development Environment](https://medium.com/@riaan.nolan/top-gun-terraform-development-environment-60ac00d49577)

## Hashiqube Integrations
![HashiQube](images/thestack.png?raw=true "HashiQube")

* [Multi Cloud](multi-cloud/#terraform-hashicorp-hashiqube) - [Hashiqube on AWS, GCP and Azure (Clustered)](https://registry.terraform.io/modules/star3am/hashiqube/hashicorp/latest)
* [Vagrant](vagrant/#vagrant) - Vagrant is an open-source software product for building and maintaining portable virtual software development environments; e.g., for VirtualBox, KVM, Hyper-V, Docker containers, VMware, and AWS. It tries to simplify the software configuration management of virtualization in order to increase development productivity `vagrant up --provision`
* [Vault](vault/#vault) - Secure, store and tightly control access to tokens, passwords, certificates, encryption keys for protecting secrets and other sensitive data using a UI, CLI, or HTTP API `vagrant up --provision-with basetools,vault`
* [Consul](consul/#consul) - Consul uses service identities and traditional networking practices to help organizations securely connect applications running in any environment `vagrant up --provision-with basetools,consul`
* [Nomad](nomad/#nomad) - A simple and flexible scheduler and orchestrator to deploy and manage containers and non-containerized applications across on-prem and clouds at scale `vagrant up --provision-with basetools,docker,nomad`
* [Traefik](nomad/#traefik-load-balancer-for-nomad) - Traefik is a modern HTTP reverse proxy and load balancer that seamlessly integrates with Nomad `vagrant up --provision-with basetools,docker,nomad` or `vagrant up --provision-with basetools,docker,minikube`
* [Fabio](nomad/#fabio-load-balancer-for-nomad) - Fabio is an HTTP and TCP reverse proxy that configures itself with data from Consul `vagrant up --provision-with basetools,docker,nomad`
* [Terraform](terraform/#terraform) - Use Infrastructure as Code to provision and manage any cloud, infrastructure, or service `vagrant up --provision-with basetools,docker,localstack,terraform`
* [Packer](packer/#packer) - Create identical machine images for multiple platforms from a single source configuration.
* [Sentinel](sentinel/#sentinel) - Sentinel is an embedded policy-as-code framework
* [Waypoint](waypoint/#waypoint) - Waypoint is an open source solution that provides a modern workflow for build, deploy, and release across platforms `vagrant up --provision-with basetools,docker,waypoint` or `vagrant up --provision-with basetools,docker,waypoint-kubernetes-minikube`
* [Boundary](boundary/#boundary) - Simple and secure remote access to any system from anywhere based on user identity `vagrant up --provision-with basetools,boundary`
* [Docker](docker/#docker) - Securely build, share and run any application, anywhere `vagrant up --provision-with basetools,docker`
* [Localstack](localstack/#localstack) - A fully functional local AWS cloud stack `vagrant up --provision-with basetools,docker,localstack,terraform`
* [Ansible](ansible/#ansible) - Ansible is a suite of software tools that enables infrastructure as code. It is open-source and the suite includes software provisioning, configuration management, and application deployment functionality.
* [LDAP](ldap/#ldap) - Lightweight Directory Access Protocol `vagrant up --provision-with basetools,vault,ldap`
* [Jenkins](jenkins/#jenkins) - Jenkins is an open source automation server. It helps automate the parts of software development related to building, testing, and deploying, facilitating continuous integration and continuous delivery `vagrant up --provision-with basetools,docker,vault,jenkins`
* [Oracle MySQL](database/#oracle-mysql) - MySQL is an open-source relational database management system (RDBMS) `vagrant up --provision-with basetools,docker,vault,mysql`
* [Microsoft MSSQL](database/#microsoft-sql-mssql-express) - Microsoft SQL Server is a relational database management system developed by Microsoft `vagrant up --provision-with basetools,docker,vault,mssql`
* [PostgreSQL](database/#postgresql) - PostgreSQL, also known as Postgres, is a free and open-source relational database management system emphasizing extensibility and SQL compliance `vagrant up --provision-with basetools,docker,vault,postgresql`
* [Minikube](minikube/#minikube) - Minikube implements a local Kubernetes cluster on macOS, Linux, and Windows `vagrant up --provision-with basetools,docker,minikube`
* [Newrelic Kubernetes Monitoring](newrelic-kubernetes-monitoring/#newrelic-kubernetes-monitoring) - Monitor Kubernetes Clusters and Workloads with Newrelic
* [Docsify](docsify/#docsify) - A magical documentation site generator `vagrant up --provision-with basetools,docsify`
* [Mermaid](mermaid/#mermaid) - Generation of diagram and flowchart from text in a similar manner as markdown
* [Prometheus](prometheus-grafana/#prometheus-and-grafana) - Open-source monitoring system with dimensional data model, flexible query language, efficient time series database & modern alerting `vagrant up --provision-with basetools,docker,minikube,prometheus-grafana`
* [Grafana](prometheus-grafana/#prometheus-and-grafana) - Grafana is the open source analytics & monitoring solution for every database `vagrant up --provision-with basetools,docker,minikube,prometheus-grafana`
* [Elasticsearch](elasticsearch-kibana-cerebro/#elasticsearch-kibana-and-cerebro) - Elasticsearch is a search engine based on the Lucene library `vagrant up --provision-with basetools,docker,elasticsearch-kibana-cerebro`
* [Kibana](elasticsearch-kibana-cerebro/#elasticsearch-kibana-and-cerebro) - Kibana is an open source data visualization dashboard for Elasticsearch `vagrant up --provision-with basetools,docker,elasticsearch-kibana-cerebro`
* [Cerebro](elasticsearch-kibana-cerebro/#elasticsearch-kibana-and-cerebro) - Cerebro is the evolution of the previous Elasticsearch plugin Elasticsearch kopf `vagrant up --provision-with basetools,docker,elasticsearch-kibana-cerebro`
* [Ansible-Tower](ansible-tower/#ansible-tower) - Is a web-based solution that makes Ansible even more easy to use for IT teams of all kinds. It’s designed to be the hub for all of your automation tasks `vagrant up --provision-with basetools,docker,minikube,ansible-tower`
* [Dbt](dbt/#dbt) - Dbt is a data transformation tool that enables data analysts and engineers to transform, test and document data in the cloud data warehouse `vagrant up --provision-with basetools,docker,postgresql,dbt`
* [Airflow](apache-airflow/#apache-airflow) - Apache Airflow is an open-source workflow management platform for data engineering pipelines `vagrant up --provision-with basetools,docker,docsify,postgresql,minikube,dbt,apache-airflow`
* [Visual-Studio-Code](visual-studio-code/#visual-studio-code) - Visual Studio Code is a code editor redefined and optimized for building and debugging modern web and cloud applications `vagrant up --provision-with basetools,docker,vscode-server`
* [Portainer](portainer/#portainer) - A lightweight service delivery platform for containerized applications that can be used to manage Docker, Swarm, Kubernetes and ACI environments. It is designed to be as simple to deploy as it is to use `vagrant up --provision-with basetools,docker,docsify,portainer`
* [Gitlab](gitlab/#gitlab) - GitLab is a complete DevOps platform, delivered as a single application `vagrant up --provision-with basetools,docker,docsify,minikube,gitlab`

Once the stack is up you will have a large number of services running and available on `localhost` <br />
For Documentation please open http://localhost:3333 in your browser

![Hashiqube Integrations](images/logo-qube.png?raw=true "Hashiqube Integrations")

## HashiQube's Purpose
Hashiqube has been created to enable anyone who is interested in secure automation pipelines the ability to run a suite of ‘best in class’ tools on their local machines at the cost of a small amount of system resources.

Hashiqube gives all interested parties the empowerment to  deploy these tools in a way that covers multiple use cases effectively providing a ‘concept to completion’ test bed using open-source Hashicorp products.

The original use case was born from the desire to demystify DevSecOps utilising Terraform, Vault, Consul, Sentinel and Nomad as well as some other well known open source CI/CD tools by providing a ‘hands-on’ environment that demonstrates the value of secret and credential management in a standard software development pipeline.

Thanks to the flexibility of the Hashicorp products there is no need to wonder how to achieve the goals of bringing software to market in a more secure and timely fashion, just Vagrant up!

## Supported Architectures
| Name | Docker | Virtualbox | Hyper-V
|------|--------|------------|---------|
| amd64 | ✓ | ✓ | ✘ |
| arm64 | ✓ | ✘ | ✘ |
| linux | ✓ | ✓ | ✘ |
| windows | ✓ | ✘ | ✘ |
| mac intel | ✓ | ✓ | ✘ |
| mac apple | ✓ | ✘ | ✘ |

## Components
Hashiqube is made up of a number of components and some rely on each other. 

For example, you can run components separately as demonstrated below.
```bash
vagrant up --provision-with basetools
vagrant up --provision-with docker
vagrant up --provision-with docsify
vagrant up --provision-with vault
vagrant up --provision-with nomad
vagrant up --provision-with minikube
```

Or one-shot as demonstrated below.
```bash
vagrant up --provision-with basetools,docker,minikube,postgresql,dbt,apache-airflow
```

#### Docker Desktop
Docker Desktop is an easy-to-install application for your Mac or Windows environment that enables you to build and share containerized applications and microservices. It's a graphical user interface for the docker service.

* [Download Docker Desktop](https://www.docker.com/products/docker-desktop) and install it on your laptop, to verify and bring up the Docker Desktop application. 

If you have HashiQube running, you won't see any containers but you will be able to open the application. 

![Docker Desktop](images/docker_desktop_installed.png?raw=true "Docker Desktop")

Now that docker is installed we need to ensure that the docker environment and settings are configured

- Ensure you have the latest version installed
- Ensure that your Operating System is updated, see: [Speed boost achievement unlocked on Docker Desktop 4.6 for Mac](https://www.docker.com/blog/speed-boost-achievement-unlocked-on-docker-desktop-4-6-for-mac/)

##### Docker Desktop Resources

:bulb: You can quite happily run Hashiqube with 4G (minimum)  or 8G (recommended) of RAM, but once you start running, Vault, Nomad, Consul, Waypoint, Boundary AND you want to run Minikube with let's say AWX Ansible Tower at the same time, the processes will start contending for resources and you will get weird errors. For that reason, the below screenshot is my setup with 12G of RAM. For reference, I use an M1 Macbook Air with 16G or RAM as my personal laptop. I frequently run all of HashiQube's services to test with, for example, I'll run Vault, Nomad, Consul, Waypoint, Boundary and Minikube with Grafana and Prometheus to test the monitoring of Vault, Nomad and Consul, for that reason 4G Ram would not be enough.

![Docker Desktop Resources](images/docker_installed_resources.png?raw=true "Docker Desktop Resources")

* Ensure that you give your docker daemon at least __8G of RAM__ and sufficient disk space

## Consul DNS
__Local DNS via Consul__ <br />
Add on our local Macbook a file __/etc/resolver/consul__ with below contents
```
nameserver 10.9.99.10
port 8600
```
Now you can use DNS like nomad.service.consul:9999 vault.service.consul:9999 via Fabio Load Balancer <br />

## The HashiStack
| Dimension | Products | | | 
|------|--------|------------|------------|
| __Applications__ | ![Nomad](https://www.datocms-assets.com/2885/1620155098-brandhcnomadprimaryattributedcolor.svg) <br /> [__Nomad__](nomad/#nomad) <br /> Schedular and workload orchestrator to deploy and manage applications | ![Waypoint](https://www.datocms-assets.com/2885/1620155130-brandhcwaypointprimaryattributedcolor.svg) <br /> [__Waypoint__](waypoint/#waypoint) <br /> One workflow to build, deploy and release applications across platforms| | 
| __Networking__ | ![Consul](https://www.datocms-assets.com/2885/1620155090-brandhcconsulprimaryattributedcolor.svg) <br /> [__Consul__](consul/#consul) <br /> Service Mesh across any cloud and runtime platform | | |
| __Security__ | ![Boundary](https://www.datocms-assets.com/2885/1620155080-brandhcboundaryprimaryattributedcolor.svg) <br /> [__Boundary__](boundary/#boundary) <br /> Secure remote access to applications and critical systems | ![Vault](https://www.datocms-assets.com/2885/1620159869-brandvaultprimaryattributedcolor.svg) <br /> [__Vault__](vault/#vault) <br /> Secure management of secrets and sensitive data| |
| __Infrastructure__ | ![Packer](https://www.datocms-assets.com/2885/1620155103-brandhcpackerprimaryattributedcolor.svg) <br /> [__Packer__](packer/#packer) <br /> Automated machine images from a single source configuration| ![Vagrant](https://www.datocms-assets.com/2885/1620155118-brandhcvagrantprimaryattributedcolor.svg) <br /> [__Vagrant__](vagrant/#vagrant) <br /> Single workflow to build and manage developer environments| ![Terraform](https://www.datocms-assets.com/2885/1620155113-brandhcterraformprimaryattributedcolor.svg) <br /> [__Terraform__](terraform/#terraform) <br /> Infrastructure automation to provision and manage any cloud service |

## Other
* LDAP can be accessed on ldap://localhost:389
* Localstack web http://localhost:8080
* DBT web http://localhost:28080
* Apache Airflow http://localhost:18889
* Ansible provisioning Apache2 http://localhost:8888
* Ansible AWX Tower http://localhost:8043
* Jenkins http://localhost:8088
* Oracle MySQL localhost:3306
* Microsoft SQL localhost:1433
* Minikube http://localhost:10888
* Traefik http://localhost:8181
* Fabio http://localhost:9999

### Vagrant Basic Usage
* `vagrant up --provision` OR `vagrant up --provision-with bootstrap|nomad|consul|vault|docker|ldap`
* `vagrant global-status` # to see which VMs are active
* `vagrant global-status --prune` # to remove stale VMs from Vagrant cache
* `vagrant status` # vagrant status
* `vagrant reload`
* `vagrant up`
* `vagrant destroy`
* `vagrant provision`
* `vagrant plugin list`

### Docker Basic Usage
* `docker image ls`
* `docker ps`
* `docker stop`

### Errors you might encounter
:bulb: If you see this error message

`vagrant destroy`

```
    hashiqube0: Are you sure you want to destroy the 'hashiqube0' VM? [y/N] y
There are errors in the configuration of this machine. Please fix
the following errors and try again:

shell provisioner:
* `path` for shell provisioner does not exist on the host system: /Users/riaan/workspace/personal/hashiqube/vault/vault.sh
```

__Command__ `docker ps` <br />
```
CONTAINER ID IMAGE COMMAND CREATED STATUS  PORTS NAMES
1d835d757279   15f77507dce7   "/usr/sbin/init"   38 hours ago   Up 38 hours   0.0.0.0:1433->1433/tcp, 0.0.0.0:3000->3000/tcp, 0.0.0.0:3306->3306/tcp, 0.0.0.0:3333->3333/tcp, 0.0.0.0:4566->4566/tcp, 0.0.0.0:4646-4648->4646-4648/tcp, 0.0.0.0:5001-5002->5001-5002/tcp, 0.0.0.0:5432->5432/tcp, 0.0.0.0:5580->5580/tcp, 0.0.0.0:5601-5602->5601-5602/tcp, 0.0.0.0:7777->7777/tcp, 0.0.0.0:8000->8000/tcp, 0.0.0.0:8043->8043/tcp, 0.0.0.0:8080->8080/tcp, 0.0.0.0:8088->8088/tcp, 0.0.0.0:8181->8181/tcp, 0.0.0.0:8200-8201->8200-8201/tcp, 0.0.0.0:8300-8302->8300-8302/tcp, 0.0.0.0:8500-8502->8500-8502/tcp, 0.0.0.0:8888-8889->8888-8889/tcp, 0.0.0.0:9001-9002->9001-9002/tcp, 0.0.0.0:9011->9011/tcp, 0.0.0.0:9022->9022/tcp, 0.0.0.0:9090->9090/tcp, 0.0.0.0:9093->9093/tcp, 0.0.0.0:9200->9200/tcp, 0.0.0.0:9333->9333/tcp, 0.0.0.0:9701-9702->9701-9702/tcp, 0.0.0.0:9998-9999->9998-9999/tcp, 0.0.0.0:10888->10888/tcp, 0.0.0.0:11888->11888/tcp, 0.0.0.0:18080->18080/tcp, 0.0.0.0:18181->18181/tcp, 0.0.0.0:18888-18889->18888-18889/tcp, 0.0.0.0:19200->19200/tcp, 0.0.0.0:19701-19702->19701-19702/tcp, 0.0.0.0:28080->28080/tcp, 0.0.0.0:31506->31506/tcp, 0.0.0.0:32022->32022/tcp, 0.0.0.0:8600->8600/udp, 0.0.0.0:2255->22/tcp, 0.0.0.0:33389->389/tcp   hashiqube_hashiqube0_1689246032
```

__Solution__ run `docker stop 1d835d757279` <br />

```
The IP address configured for the host-only network is not within the
allowed ranges. Please update the address used to be within the allowed
ranges and run the command again.

Address: 10.9.99.10
Ranges: 192.168.56.0/21

Valid ranges can be modified in the /etc/vbox/networks.conf file. For
more information including valid format see:

https://www.virtualbox.org/manual/ch06.html#network_hostonly
```

Please create the following file: __/etc/vbox/networks.conf__ with the following contents

```
* 10.0.0.0/8 192.168.0.0/16
* 2001::/64
``` 

and re-run `vagrant up --provision`

__Error__ response from daemon: cannot stop container: 6c0c8135620ff47efe12df417a0df0e57d7a81a7f7ca06d011323fbb52e573db: tried to kill container, but did not receive an exit event <br />
__Command__ `vagrant destroy` <br />
__Solution__ run `vagrant destroy` again <br />

```
    hashiqube0.service.consul: Are you sure you want to destroy the 'hashiqube0.service.consul' VM? [y/N] y
==> hashiqube0.service.consul: Stopping container...
A Docker command executed by Vagrant didn't complete successfully!
The command run along with the output from the command is shown
below.

Command: ["docker", "stop", "-t", "1", "6c0c8135620ff47efe12df417a0df0e57d7a81a7f7ca06d011323fbb52e573db", {:notify=>[:stdout, :stderr]}]

Stderr: Error response from daemon: cannot stop container: 6c0c8135620ff47efe12df417a0df0e57d7a81a7f7ca06d011323fbb52e573db: tried to kill container, but did not receive an exit event
```

__Error__ The IP address configured for the host-only network is not within the allowed ranges. Please 
update the address used to be within the allowed ranges and run the command again. <br />
__Command__ `vagrant up --provision` <br /> 
__Solution__ Ensure the following contents are present in `/etc/vbox/networks.conf` <br>

```
* 10.0.0.0/8 192.168.0.0/16
* 2001::/64
```

__Error__ Vagrant cannot forward the specified ports on this VM, since they would collide with some other application that is already listening on these ports. The forwarded port to `9200` is already in use on the host machine.

To fix this, modify your current project's Vagrantfile to use another port. For example, where '1234' would be replaced by a unique host port: 

```
config.vm.network :forwarded_port, guest: 9200, host: 1234
```

Sometimes, Vagrant will attempt to auto-correct this for you. In this case, Vagrant was unable to. This is usually because the guest machine is in a state which doesn't allow modifying port forwarding. You could try 'vagrant reload' (the equivalent of running a halt followed by an up) so vagrant can attempt to auto-correct this upon booting. Be warned that any unsaved work might be lost. <br />
__Command__ `vagrant up --provision` <br />
__Info__ When I run `vagrant up` I get an error about a port collision, in this case, it is port `9200` - The reason is that I have an Elasticsearch container running on my local laptop, and since HashiQube also run Elasticsearch this port is taken. <br />
__Solution__ I stop the Elasticsearch docker container and I run `vagrant up` again, or I hash the line out in the Vagrantfile like the example below <br />

```
# config.vm.network "forwarded_port", guest: 9200, host: 9200 # elasticsearch
```

## Support & Feedback
For suggestions, feedback and queries please branch or and submit a Pull Request or directly contact __Riaan Nolan__, creator of the HashiQube via [Github - hashiqube](https://github.com/star3am/hashiqube)


### About Hashiqube
Hashiqube runs all the Hashicorp products and a host of other popular Open Source software that is heavily used in the industry. 

Once you have done `vagrant up --provision` you will have access to Vault, Nomad, Consul, Boundary, Waypoint and this documentation page on your local computer.

* Vault http://localhost:8200 `vagrant up --provision-with basetools,vault`
* Nomad http://localhost:4646 `vagrant up --provision-with basetools,docker,nomad`
* Consul http://localhost:8500 `vagrant up --provision-with basetools,consul`
* Waypoint on Nomad https://localhost:9702 `vagrant up --provision-with basetools,docker,waypoint`
* Waypoint on Minikube https://localhost:19702 `vagrant up --provision-with basetools,docker,waypoint-kubernetes-minikube`
* Boundary http://localhost:19200 `vagrant up --provision-with basetools,boundary`
* Docsify http://localhost:3333 `vagrant up --provision-with basetools,docsify`

In addition to the Core Hashicorp products, Hashiqube also runs a host of other popular Open Source integrations that are heavily used within the industry today. 

![Hashiqube Integrations](images/logo-qube.png?raw=true "Hashiqube Integrations")

### About Me
My name is __Riaan Nolan__ and I was born in South Africa. I started out as a Web Developer in 2000 and from there progressed into Systems Administration, with a strong focus on Automation, Infrastructure and Configuration as Code.

I have worked for Multi-National companies in Portugal, Germany, China, South Africa, United States and Australia. 

Please connect with me on [LinkedIn](https://www.linkedin.com/in/riaannolan/) or check out [my Credly profile](https://www.credly.com/users/riaan-nolan.e657145c)
<br />

![My Hashicorp Badges](images/hashicorp-badges.png?raw=true "My Hashicorp Badges")

## Contributors and Special mentions
A Very special mention to HashiQube's contributors, Thank You All for your help, suggestions and contributions no matter how small <3
 - Thomas Cockin
 - Konstantin Vanyushov
 - Tristan Morgan
 - Ringo Chan
 - Ehsan Mirzaei
 - Greg Luxford
 - Byron Tuckett
 - Lane Birmingham
 - Devang Dhameliya
 - Rajesh Cholleti
 - Nel-Marie Nolan
 - Adriana Villela
 - [Charle Van Der Walt](https://linkedin.com/in/charle-van-der-walt-b9ba2628/)
 - [JJ Badenhorst](https://github.com/badj)

## Videos
Videos were made with [asciinema](https://asciinema.org/)
- asciinema rec -i 1
- asciicast2gif -S 1 -s 2 tmpd1zpq13n-ascii.cast tmpd1zpq13n-ascii.gif

## License
HashiQube is available as open-source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

![Automate all the things](images/automate-all-the-things.png?raw=true "Automate all the things")
