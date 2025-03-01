# Vagrant

<div align="center">
  <p><strong>Create and configure lightweight, reproducible, and portable development environments</strong></p>
</div>

![Vagrant Logo](images/vagrant-logo.png?raw=true "Vagrant Logo")

## 🚀 Introduction

[HashiCorp Vagrant](https://www.vagrantup.com/) provides the same, easy workflow regardless of your role as a developer, operator, or designer. It leverages a declarative configuration file which describes all your software requirements, packages, operating system configuration, users, and more.

With Vagrant, you can quickly spin up consistent environments across your team, ensuring that "it works on my machine" becomes "it works on every machine."

## 📄 The Vagrantfile

The Vagrantfile is the heart of Vagrant, defining your development environment's configuration:

```ruby
[filename](../Vagrantfile.txt ':include :type=code ruby')
```

## 🛠️ Provisioning

Start your environment with a simple command:

```bash
vagrant up --provision
```

### Provisioning Output

When you run the provisioning command, you'll see output similar to this:

```log
Bringing machine 'user.local.dev' up with 'virtualbox' provider...
==> user.local.dev: Checking if box 'ubuntu/xenial64' version '20190918.0.0' is up to date...
==> user.local.dev: [vagrant-hostsupdater] Checking for host entries
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: Running provisioner: bootstrap (shell)...
    user.local.dev: Running: inline script
    user.local.dev: BEGIN BOOTSTRAP 2020-01-10 00:44:49
    user.local.dev: running vagrant as user
    user.local.dev: Get:1 https://deb.nodesource.com/node_10.x xenial InRelease [4,584 B]
    ...
    user.local.dev: END BOOTSTRAP 2020-01-10 00:45:53
```

## 🧩 Included Components

The HashiQube environment provisions multiple HashiCorp tools and supporting services:

### Docker

```log
==> user.local.dev: Running provisioner: docker (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-35289-lj8d6b.sh
    ...
    user.local.dev: ++++ open http://localhost:8889 in your browser
    user.local.dev: ++++ you can also run below to get apache2 version from the docker container
    user.local.dev: ++++ vagrant ssh -c "docker exec -it apache2 /bin/bash -c 'apache2 -t -v'"
```

### Terraform

```log
==> user.local.dev: Running provisioner: terraform (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-35289-gf77w9.sh
    ...
    user.local.dev: ++++ Terraform v0.12.18 already installed at /usr/local/bin/terraform
```

### Vault

```log
==> user.local.dev: Running provisioner: vault (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-35289-igtj7e.sh
    ...
    user.local.dev: ++++ Vault already installed and running
    user.local.dev: ++++ Vault http://localhost:8200/ui and enter the following codes displayed below
    ...
```

### Consul

```log
==> user.local.dev: Running provisioner: consul (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-35289-u3hjac.sh
    user.local.dev: Reading package lists...
    ...
    user.local.dev: ++++ Adding Consul KV data for Fabio Load Balancer Routes
    user.local.dev: Success! Data written to: fabio/config/vault
    user.local.dev: Success! Data written to: fabio/config/nomad
    user.local.dev: Success! Data written to: fabio/config/consul
    user.local.dev: ++++ Consul http://localhost:8500
```

### Nomad

```log
==> user.local.dev: Running provisioner: nomad (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-35289-1s3k8i2.sh
    ...
    user.local.dev: ++++ Nomad already installed at /usr/local/bin/nomad
    user.local.dev: ++++ Nomad v0.10.2 (0d2d6e3dc5a171c21f8f31fa117c8a765eb4fc02)
    user.local.dev: ++++ cni-plugins already installed
    user.local.dev: ==> Loaded configuration from /etc/nomad/server.conf
    user.local.dev: ==> Starting Nomad agent...
    ...
```

### Additional Components

- **Packer**: For building automated machine images
- **Sentinel**: For policy as code framework
- **LocalStack**: For AWS cloud stack emulation
- **Docsify**: For documentation (<http://localhost:3333/>)

## 📊 Accessing Services

After provisioning completes, you can access the following services:

| Service | URL | Description |
|---------|-----|-------------|
| Vault | <http://localhost:8200/ui> | Secrets management |
| Consul | <http://localhost:8500> | Service discovery and configuration |
| Nomad | <http://localhost:4646> | Workload orchestration |
| Docker | <http://localhost:8889> | Container management |
| Docsify | <http://localhost:3333> | Documentation |

## 🔍 Common Commands

- **Start the environment**: `vagrant up`
- **SSH into the VM**: `vagrant ssh`
- **Stop the environment**: `vagrant halt`
- **Destroy the environment**: `vagrant destroy`
- **Provision again**: `vagrant provision`
- **Check status**: `vagrant status`

## 📚 Resources

- [Vagrant Documentation](https://www.vagrantup.com/docs)
- [HashiCorp Developer Portal](https://developer.hashicorp.com/)
- [Vagrant GitHub Repository](https://github.com/hashicorp/vagrant)
