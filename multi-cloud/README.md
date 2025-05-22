# terraform-hashicorp-hashiqube

<div align="center">
  <p><strong>Terraform Registry Module for deploying HashiQube - a Development Lab using all the HashiCorp Products</strong></p>
</div>

## 🚀 Introduction

Hello friends!

This repository contains a [Terraform](https://www.terraform.io/) module for provisioning [HashiQube](https://hashiqube.com) - a **Development** lab running all [HashiCorp](https://www.hashicorp.com/) products. It enables you to deploy Hashicorp's clustered Consul, Nomad and Vault HA in GCP, AWS, and Azure using Terraform.

I created HashiQube to help developers and engineers get up to speed with HashiCorp products for development, testing, or training purposes. You can learn more about it in my [HashiTalks 2020 presentation](https://www.hashicorp.com/resources/hashiqube-a-development-lab-using-all-the-hashicorp-products/).

> ⚠️ **WARNING**: DO NOT USE HASHIQUBE IN PRODUCTION

![HashiQube Integrations](images/logo-qube.png?raw=true "HashiQube Integrations")

## 🛠️ Basic Concept

The basic concept is:

1. We spin up a cloud instance
2. We install `docker` and `vagrant` on it
3. We clone <https://github.com/star3am/hashiqube> into /home/ubuntu/hashiqube
4. We use vagrant to spin up HashiQube as a docker container with all the HashiCorp tools inside

Vault, Nomad, Consul, Boundary, and Waypoint actually run inside a docker container on the cloud instance:

```bash
# Check the vagrant status
ubuntu@hashiqube-aws:~$ vagrant status

Current machine states:
hashiqube0.service.consul running (docker)

# Check running containers
ubuntu@hashiqube-aws:~$ docker ps
CONTAINER ID   IMAGE          COMMAND            CREATED          STATUS          PORTS   NAMES
f6bc621e730e   7b224f871e2a   "/usr/sbin/init"   58 minutes ago   Up 58 minutes   0.0.0.0:1433->1433/tcp, :::1433->1433/tcp, 0.0.0.0:3306->3306/tcp, :::3306->3306/tcp, 0.0.0.0:3333->3333/tcp, :::3333->3333/tcp, 0.0.0.0:4566->4566/tcp, :::4566->4566/tcp, 0.0.0.0:4646-4648->4646-4648/tcp, :::4646-4648->4646-4648/tcp, 0.0.0.0:5001-5002->5001-5002/tcp, :::5001-5002->5001-5002/tcp, 0.0.0.0:5432->5432/tcp, :::5432->5432/tcp, 0.0.0.0:7777->7777/tcp, :::7777->7777/tcp, 0.0.0.0:8000->8000/tcp, :::8000->8000/tcp, 0.0.0.0:8043->8043/tcp, :::8043->8043/tcp, 0.0.0.0:8080->8080/tcp, :::8080->8080/tcp, 0.0.0.0:8088->8088/tcp, :::8088->8088/tcp, 0.0.0.0:8181->8181/tcp, :::8181->8181/tcp, 0.0.0.0:8200->8200/tcp, :::8200->8200/tcp, 0.0.0.0:8300-8302->8300-8302/tcp, :::8300-8302->8300-8302/tcp, 0.0.0.0:8500->8500/tcp, :::8500->8500/tcp, 0.0.0.0:8888-8889->8888-8889/tcp, :::8888-8889->8888-8889/tcp, 0.0.0.0:9001-9002->9001-9002/tcp, :::9001-9002->9001-9002/tcp, 0.0.0.0:9011->9011/tcp, :::9011->9011/tcp, 0.0.0.0:9022->9022/tcp, :::9022->9022/tcp, 0.0.0.0:9701-9702->9701-9702/tcp, :::9701-9702->9701-9702/tcp, 0.0.0.0:9998-9999->9998-9999/tcp, :::9998-9999->9998-9999/tcp, 0.0.0.0:10888->10888/tcp, :::10888->10888/tcp, 0.0.0.0:18080->18080/tcp, :::18080->18080/tcp, 0.0.0.0:18181->18181/tcp, :::18181->18181/tcp, 0.0.0.0:18888-18889->18888-18889/tcp, :::18888-18889->18888-18889/tcp, 0.0.0.0:19200->19200/tcp, :::19200->19200/tcp, 0.0.0.0:19701-19702->19701-19702/tcp, :::19701-19702->19701-19702/tcp, 0.0.0.0:28080->28080/tcp, :::28080->28080/tcp, 0.0.0.0:31506->31506/tcp, :::31506->31506/tcp, 0.0.0.0:8600->8600/udp, :::8600->8600/udp, 0.0.0.0:2255->22/tcp, :::2255->22/tcp, 0.0.0.0:33389->389/tcp, :::33389->389/tcp   hashiqube_hashiqube0serviceconsul_1684968900
```

## 🚀 Quickstart

### Prerequisites

- A Cloud account (AWS, GCP, Azure)
- SSH public/private key pair

### Development Environment Setup

1. **Download and Install VSCode**: <https://code.visualstudio.com/>
2. **Install VSCode Remote Containers extension**: <https://code.visualstudio.com/docs/devcontainers/containers>
3. **Install Docker Desktop**
4. **Configure Cloud Authentication**

Export the following environment variables:

```bash
# AWS Authentication
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables
export AWS_ACCESS_KEY_ID=YOUR_AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY=YOUR_AWS_SECRET_ACCESS_KEY
export AWS_REGION=YOUR_AWS_REGION

# GCP Authentication
# https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference.html#authentication-configuration
export GOOGLE_CREDENTIALS='YOUR_GOOGLE_CREDENTIALS_FILE_JSON'

# Azure Authentication
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal
export ARM_CLIENT_ID=YOUR_ARM_CLIENT_ID
export ARM_CLIENT_SECRET=YOUR_ARM_CLIENT_SECRET
export ARM_SUBSCRIPTION_ID=YOUR_ARM_SUBSCRIPTION_ID
export ARM_TENANT_ID=YOUR_ARM_TENANT_ID
```

5. **Copy `terraform.auto.tfvars.example` to `terraform.auto.tfvars`** and fill in the details
6. **Run Terraform**:

   ```bash
   terraform init -upgrade
   terraform apply
   ```

## 📊 Accessing HashiQube

The Terraform output will provide all the URLs and SSH commands you need:

```bash
Outputs:

aaa_welcome = <<EOT
Your HashiQube instance is busy launching, usually this takes ~5 minutes.
Below are some links to open in your browser, and commands you can copy and paste in a terminal to login via SSH into your HashiQube instance.
Thank you for using this module, you are most welcome to fork this repository to make it your own.
** DO NOT USE THIS IN PRODUCTION **

EOT
aws_hashiqube-boundary = "http://13.55.129.xxx:9200 username: admin password: password"
aws_hashiqube-consul = "http://13.55.129.xxx:8500"
aws_hashiqube-fabio-lb = "http://13.55.129.xxx:9999"
aws_hashiqube-fabio-ui = "http://13.55.129.xxx:9998"
aws_hashiqube-nomad = "http://13.55.129.xxx:4646"
aws_hashiqube-ssh = "ssh ubuntu@13.55.129.xxx"
aws_hashiqube-traefik-lb = "http://13.55.129.xxx:8080"
aws_hashiqube-traefik-ui = "http://13.55.129.xxx:8181"
aws_hashiqube-vault = "http://13.55.129.xxx:8200"
aws_hashiqube-waypoint = "https://13.55.129.xxx:9702"
# Additional outputs for Azure and GCP instances
```

### First Login

After your HashiQube instances have been launched, you can access them using the SSH commands from the Terraform output.

![HashiQube Access](images/hashiqube-first-login.png?raw=true "HashiQube Access")

### Bash Aliases for Easier Interaction

A `~/.bash_aliases` file is used to make it easier to interact with HashiCorp tools running in the HashiQube docker container:

```bash
alias vagrant='cd /home/ubuntu/hashiqube; vagrant'
nomad() { cd /home/ubuntu/hashiqube; vagrant ssh -c "nomad $1 $2 $3 $4 $5" ;}
consul() { cd /home/ubuntu/hashiqube; vagrant ssh -c "consul $1 $2 $3 $4 $5" ;}
vault() { cd /home/ubuntu/hashiqube; vagrant ssh -c "vault $1 $2 $3 $4 $5" ;}
waypoint() { cd /home/ubuntu/hashiqube; vagrant ssh -c "waypoint $1 $2 $3 $4 $5" ;}
boundary() { cd /home/ubuntu/hashiqube; vagrant ssh -c "boundary $1 $2 $3 $4 $5" ;}
```

> 💡 When you issue the command `vault` or `nomad` or `consul`, it is ACTUALLY executed via `vagrant ssh -c $command`

### Interacting with HashiCorp Services

**Get Vault status**:

```bash
ubuntu@hashiqube-aws:~/hashiqube# vault status
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    5
Threshold       3
Version         1.13.2
Build Date      2023-04-25T13:02:50Z
Storage Type    file
Cluster Name    vault
Cluster ID      4731c701-5575-be22-6678-8ba210f7f045
HA Enabled      false
```

**Get Nomad Job Status**:

```bash
ubuntu@hashiqube-aws:~/hashiqube# nomad job status
ID                                            Type     Priority  Status   Submit Date
fabio                                         system   50        running  2023-05-23T22:59:55Z
nomad-trex-nodejs-01h15dkdgxxp6pw1fa7409q59z  service  10        running  2023-05-23T23:02:42Z
nomad-trex-nodejs-01h15dkhnh3zzwa03jdjvsh6e5  service  10        running  2023-05-23T23:02:46Z
traefik                                       service  50        running  2023-05-23T22:59:56Z
traefik-whoami                                service  50        running  2023-05-23T23:00:15Z
waypoint-server                               service  50        running  2023-05-23T23:00:47Z
```

**Get Nomad Server Members**:

```bash
ubuntu@hashiqube-aws:~/hashiqube# nomad server members
Name                                   Address     Port  Status  Leader  Raft Version  Build  Datacenter  Region
hashiqube-aws.service.consul.global    10.9.99.11  5648  alive   true    3             1.5.6  aws         global
hashiqube-azure.service.consul.global  10.9.99.13  5648  failed  false   3             1.5.6  azure       global
hashiqube-gcp.service.consul.global    10.9.99.12  5648  failed  false   3             1.5.6  gcp         global
```

**Get Consul Members**:

```bash
ubuntu@hashiqube-aws:~/hashiqube# consul members -wan
Node                                  Address          Status  Type    Build   Protocol  DC     Partition  Segment
hashiqube-aws.service.consul.aws      10.9.99.11:8302  alive   server  1.15.2  3         aws    default    <all>
hashiqube-azure.service.consul.azure  10.9.99.13:8302  failed  server  1.15.2  3         azure  default    <all>
hashiqube-gcp.service.consul.gcp      10.9.99.12:8302  failed  server  1.15.2  3         gcp    default    <all>
```

### Web Interfaces

**Access Waypoint**:

```bash
aws_hashiqube-waypoint = "https://13.55.129.xxx:9702"
```

![HashiCorp Waypoint on HashiQube](images/hashiqube-waypoint.png?raw=true "HashiCorp Waypoint on HashiQube")

**Access Boundary**:

```bash
aws_hashiqube-boundary = "http://13.55.129.152:9200 username: admin password: password"
```

![HashiCorp Boundary on HashiQube](images/hashiqube-boundary.png?raw=true "HashiCorp Boundary on HashiQube")

## 🧩 Module Usage

### Options for Using this Module

1. **Clone the repository** and edit the variables.tf file or rename terraform.auto.tfvars.example to terraform.auto.tfvars
2. **Use the module from the Terraform Registry** (see examples folder)

### Enable Cloud Deployments

Edit `variables.tf` to enable your preferred cloud platforms:

```hcl
variable "deploy_to_aws" {
  type        = bool
  default     = true
  description = "Deploy HashiQube on AWS"
}

variable "deploy_to_gcp" {
  type        = bool
  default     = true
  description = "Deploy HashiQube on GCP"
}

variable "deploy_to_azure" {
  type        = bool
  default     = true
  description = "Deploy HashiQube on Azure"
}
```

### SSH Access

Your IP will be whitelisted and you can access the cloud instances with the commands from the Terraform output:

```bash
# For GCP
ssh ubuntu@34.87.247.xxx

# For Azure
ssh ubuntu@20.53.246.xxx

# For AWS
ssh ubuntu@3.105.237.xxx
```

Your SSH public key (`~/.ssh/id_rsa.pub`) will be added to the instances.

## 📚 What is a Terraform Module?

A Terraform "module" refers to a self-contained package of Terraform configurations that are managed as a group.
For more information around modules refer to the Terraform [documentation](https://www.terraform.io/docs/modules/index.html).

## 💼 Development Environment

![VSCode Dev Containers](images/vscode-dev-containers.png?raw=true "VSCode Dev Containers")

### VSCode Dev Containers

The [Visual Studio Code Dev Containers extension](https://code.visualstudio.com/docs/devcontainers/containers) lets you use a container as a full-featured development environment.

### Recommended VSCode Extensions

- [Azure Terraform Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureterraform)
- [Terraform Extension](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform)
- [Git History Extension](https://marketplace.visualstudio.com/items?itemName=donjayamanne.githistory)
- [GitLens Extension](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens)
- [YAML Extension](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml)
- [Docker Remote Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- [AWS Toolkit](https://aws.amazon.com/visualstudiocode/)
- [AWS CloudFormation Extension](https://marketplace.visualstudio.com/items?itemName=aws-scripting-guy.cform)
- [Dracula Dark Theme](https://marketplace.visualstudio.com/items?itemName=dracula-theme.theme-dracula)
- [Live Share Extension](https://marketplace.visualstudio.com/items?itemName=MS-vsliveshare.vsliveshare-pack)

## 📊 Module Documentation

### Inputs

| Name | Type | Default | Description |
|------|-------------|------|---------|
| deploy_to_aws | bool | false | Deploy HashiQube on AWS |
| deploy_to_gcp | bool | false | Deploy HashiQube on GCP |
| deploy_to_azure | bool | false | Deploy HashiQube on Azure |
| whitelist_cidr | string | "" | Additional CIDR to whitelist |
| ssh_public_key | string | "~/.ssh/id_rsa.pub" | SSH public key |
| azure_region | string | "Australia East" | The region in which all Azure resources will be launched |
| azure_instance_type | string | "Standard_F2" | Azure instance type |
| aws_credentials | string | "~/.aws/credentials" | AWS credentials file location |
| aws_profile | string | "default" | AWS profile |
| aws_region | string | "ap-southeast-2" | The region in which all AWS resources will be launched |
| aws_instance_type | string | "t2.medium" | AWS instance type |
| gcp_credentials | string | "~/.gcp/credentials.json" | GCP Credentials file |
| gcp_project | string | "riaan-nolan-xxx" | GCP project ID |
| gcp_region | string | "australia-southeast1" | The region in which all GCP resources will be launched |
| gcp_account_id | string | "sa-consul-compute-prod" | GCP Account ID |
| gcp_cluster_name | string | "hashiqube" | GCP Cluster name |
| gcp_cluster_description | string | "hashiqube" | The description for the cluster |
| gcp_cluster_tag_name | string | "hashiqube" | GCP Cluster tag to apply |
| gcp_cluster_size | number | 1 | GCP size of the cluster |
| gcp_zones| list(string) | ["australia-southeast1-a","australia-southeast1-b","australia-southeast1-c"] | The zones across which GCP resources will be launched |
| gcp_machine_type | string | "n1-standard-1" | GCP machine type |
| gcp_custom_metadata | map(string) | {} | A map of metadata key value pairs to assign to the Compute Instance metadata |
| gcp_root_volume_disk_size_gb | number | 16 | The size, in GB, of the root disk volume on each HashiQube node |
| gcp_root_volume_disk_type | string | "pd-standard" | The GCE disk type. Can be either pd-ssd, local-ssd, or pd-standard |

### Outputs

| Name | Description |
|------|-------------|
| ip_address | The IP address of HashiQube instance |
| aws_hashiqube-consul | http://aws_hashiqube-consul:8500 |
| aws_hashiqube-fabio-lb | http://aws_hashiqube-fabio-lb:9999 |
| aws_hashiqube-fabio-ui | http://aws_hashiqube-fabio-ui:9998 |
| aws_hashiqube-nomad | http://aws_hashiqube-nomad:4646 |
| aws_hashiqube-ssh | ssh <ubuntu@54.206.165.xxx> |
| aws_hashiqube-vault | http://aws_hashiqube-vault:8200 |
| aws_hashiqube_ip | 54.206.165.xxx |
| azure_hashiqube-consul | http://azure_hashiqube-consul:8500 |
| azure_hashiqube-fabio-lb | http://azure_hashiqube-fabio-lb:9999 |
| azure_hashiqube-fabio-ui | http://azure_hashiqube-fabio-ui:9998 |
| azure_hashiqube-nomad | http://azure_hashiqube-nomad:4646 |
| azure_hashiqube-ssh | ssh <ubuntu@13.75.237.xxx> |
| azure_hashiqube-vault | http://azure_hashiqube-vault:8200 |
| azure_hashiqube_ip | 13.75.237.xxx |
| gcp_hashiqube-consul | http://gcp_hashiqube-consul:8500 |
| gcp_hashiqube-fabio-lb | http://gcp_hashiqube-fabio-lb:9999 |
| gcp_hashiqube-fabio-ui | http://gcp_hashiqube-fabio-ui:9998 |
| gcp_hashiqube-nomad | http://gcp_hashiqube-nomad:4646 |
| gcp_hashiqube-ssh | ssh <ubuntu@34.87.219.xxx> |
| gcp_hashiqube-vault | http://gcp_hashiqube-vault:8200 |
| gcp_hashiqube_ip | 34.87.219.xxx |
| your_ipaddress | 103.234.250.xxx |

## 🔗 Links

- [HashiCorp blog post](https://www.hashicorp.com/resources/hashiqube-a-development-lab-using-all-the-hashicorp-products)
- [HashiQube website](https://hashiqube.com)
- [HashiQube github](https://github.com/star3am/hashiqube)
- [HashiQube youtube](https://www.youtube.com/watch?v=6jGDAGWaFiw)
- [HashiQube medium](https://medium.com/search?q=hashiqube)

## 💡 Purpose

HashiQube has been created to help developers and engineers get up to speed with HashiCorp products. It can be used for development, testing, or training. HashiQube gives all interested parties the empowerment to deploy these tools in a way that covers multiple use cases effectively providing a 'concept to completion' testbed using open-source HashiCorp products.

![HashiQube Dev Lab](images/thestack.png?raw=true "HashiQube Dev Lab")

## 👨‍💻 About Me

My name is Riaan Nolan and I was born in South Africa. I started out as a Web Developer in 2000 and from there progressed into Systems Administration, with a strong focus on Automation, Infrastructure and Configuration as Code.

I have worked for Multi-National companies in Portugal, Germany, China, South Africa, United States, and Australia.

You are welcome to connect with me on [LinkedIn](https://www.linkedin.com/in/riaannolan/) and check out my [Credly profile](https://www.credly.com/users/riaan-nolan.e657145c).

![My HashiCorp Badges](images/hashicorp-badges.png?raw=true "My HashiCorp Badges")

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')
