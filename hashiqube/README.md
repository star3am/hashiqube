# HashiQube

<div align="center">
  <img src="../images/logo-qube.png" alt="HashiQube Logo" width="300px">
  <br><br>
  <p><strong>The Ultimate Hands-on DevOps Lab in a Docker Container</strong></p>
</div>

## 🚀 About

HashiQube is your complete DevOps playground, designed to help engineers, developers, and anyone interested in learning or demonstrating HashiCorp products. It's a self-contained environment that runs all HashiCorp products and integrates with popular open-source DevOps/DevSecOps applications.

### Key Features

- **Complete HashiCorp Stack**: Run [Vault](/vault/?id=vault), [Terraform](/terraform/?id=terraform), [Nomad](/nomad/?id=nomad), [Consul](/consul/?id=consul), [Waypoint](/waypoint/?id=waypoint), [Boundary](/boundary/?id=boundary), [Vagrant](/vagrant/?id=vagrant), [Packer](/packer/?id=packer), and [Sentinel](/sentinel/?id=sentinel) in one place.

- **Additional DevOps Tools**: Includes Minikube, Ansible AWX Tower, Traefik, and more to demonstrate integration with HashiCorp products.

- **Offline Capability**: Once set up, an internet connection is no longer needed, making it perfect for demos, sales pitches, and learning environments.

- **Nested Containerization**: HashiQube has a Docker daemon inside, allowing you to run containers using Kubernetes (Minikube), Nomad, or Docker run.

## 📋 Provision

<!-- tabs:start -->

### **Github Codespace**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash vault/vault.sh
bash consul/consul.sh
bash nomad/nomad.sh
bash boundary/boundary.sh
```

### **Vagrant**

```bash
vagrant up --provision
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash vault/vault.sh
bash consul/consul.sh
bash nomad/nomad.sh
bash boundary/boundary.sh
```

<!-- tabs:end -->

## 🎥 Introduction Video

Watch a short introduction to HashiQube. Make sure you have HashiQube running so you can follow along on your own machine!

<div align="center">
  <a href="https://www.youtube.com/watch?v=sFiWzKbpEpU">
    <img src="/images/youtube-hashiqube-the-jedi-devops-lab.png" alt="HashiQube: A Jedi DevOps Lab Using All the HashiCorp Products" width="85%">
  </a>
  <p><em>Click to watch "HashiQube: A Jedi DevOps Lab Using All the HashiCorp Products"</em></p>
</div>

## 🔗 Resources

Find more information about HashiQube on these channels:

- [HashiCorp Blog Post](https://www.hashicorp.com/resources/hashiqube-a-development-lab-using-all-the-hashicorp-products)
- [HashiQube Website](https://hashiqube.com)
- [HashiQube GitHub](https://github.com/star3am/hashiqube)
- [HashiQube YouTube](https://www.youtube.com/watch?v=6jGDAGWaFiw)
- [HashiQube Medium Articles](https://medium.com/search?q=hashiqube)
- [HashiQube Terraform Registry Module](https://registry.terraform.io/modules/star3am/hashiqube/hashicorp/latest)
- [Terraform Development Environment Article](https://medium.com/@riaan.nolan/top-gun-terraform-development-environment-60ac00d49577)

## 🛠️ Basetools Provider

The Basetools provider installs essential tools that HashiQube provisioners need. This is one of the first provisioners that must be run. It installs:

```bash
swapspace rkhunter jq curl unzip software-properties-common bzip2 git make 
python3.9 python3-pip python3-dev python3-venv python3-virtualenv golang-go 
apt-utils ntp update-motd toilet figlet nano iputils-ping dnsutils iptables telnet
```

### Basetools Provisioner Script

The script below automates the setup of basic tools in your HashiQube environment:

```bash
#!/bin/bash

# Print the commands that are run
set -x

# Stop execution if something fails
set -e

# This script provisions base tools we will need

# Update apt
if [ -x "$(command -v apt)" ]; then
  # We want to be able to install add-apt-repository
  apt-get update && apt-get install -y sudo software-properties-common ntp update-motd toilet figlet nano
  # Add Latest Python PPA
  sudo apt-add-repository -y ppa:deadsnakes/ppa
  # add this for apt install debian-goodies
  sudo apt-add-repository -y ppa:apt-fast/stable
  sudo apt-get update
  # Install some apt packages needed
  sudo apt-get install -y \
    swapspace rkhunter jq curl unzip software-properties-common bzip2 git make python3.9 python3-pip python3-dev python3-venv python3-virtualenv golang-go apt-utils ntp update-motd toilet figlet nano iputils-ping dnsutils iptables telnet
fi

sudo update-alternatives --install /usr/bin/python python /usr/bin/python3 1
sudo update-alternatives --install /usr/bin/pip pip /usr/bin/pip3 1

# Set Message Of The Day (MOTD)
motd()
{
  # Set Message of the day
  sudo rm -f /etc/update-motd.d/10-help-text
  sudo rm -f /etc/update-motd.d/51-cloudguest
  sudo rm -f /etc/update-motd.d/50-landscape-sysinfo
  sudo rm -f /etc/update-motd.d/90-updates-available
  sudo rm -f /etc/update-motd.d/91-release-upgrade
  sudo rm -f /etc/update-motd.d/94-*
  sudo rm -f /etc/update-motd.d/97-*
  sudo rm -f /etc/update-motd.d/00-header
  sudo sh -c 'echo "#!/bin/sh" > /etc/update-motd.d/00-header'
  sudo sh -c 'figlet -f slant "Hashiqube">> /etc/update-motd.d/00-header'
  sudo sh -c 'echo "\nHashiqube - Vagrant lab environment for learning Hashicorp products and playing with integrations\n" >> /etc/update-motd.d/00-header'
  sudo sh -c 'toilet -f term --filter metal "Hashiqube is for learning Hashicorp products and playing with integrations" >> /etc/update-motd.d/00-header'
  sudo sh -c 'echo "find out more at https://hashiqube.com\n" >> /etc/update-motd.d/00-header'
  sudo sh -c 'echo "Please report any issues to https://github.com/star3am/hashiqube\n" >> /etc/update-motd.d/00-header'
  sudo chmod +x /etc/update-motd.d/00-header
}
motd
```

## 🌐 HashiQube.com Deployment

<div align="center">
  <p><em>WORK IN PROGRESS</em></p>
</div>

As you might expect, HashiQube.com is deployed using HashiCorp tools - specifically, Waypoint. Here's how it works:

### 1. Set Up Local Environment

```bash
# Bring up HashiQube locally with the necessary components
vagrant up --provision-with basetools,docker,terraform,nomad,waypoint

# SSH into HashiQube
vagrant ssh
```

### 2. Configure AWS Credentials

Create or edit `~/.aws/config`:

```ini
[default]
region =
aws_access_key_id =
aws_secret_access_key =
output = json
```

### 3. Navigate to Project Directory

```bash
cd /vagrant
```

### 4. Initialize Waypoint

```bash
waypoint init
```

Output:

```bash
✓ Configuration file appears valid
✓ Connection to Waypoint server was successful
✓ Project "hashiqube" and all apps are registered with the server.
✓ Project "hashiqube" pipelines are registered with the server.

Project initialized!

You may now call 'waypoint up' to deploy your project or
commands such as 'waypoint build' to perform steps individually.
```

### 5. Deploy with Waypoint

```bash
waypoint up
```

This command builds and deploys the HashiQube website. The process includes:

- Building a Docker image
- Pushing to ECR
- Deploying to ECS
- Setting up load balancers and target groups

### 6. Cleanup Resources (When Needed)

```bash
waypoint destroy
```

## 👤 Connect

Please connect with the creator:

- [LinkedIn (Riaan Nolan)](https://www.linkedin.com/in/riaannolan/)
- [Credly Profile](https://www.credly.com/users/riaan-nolan.e657145c)

[filename](basetools.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')