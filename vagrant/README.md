# Vagrant

https://www.vagrantup.com/

![Vagrant Logo](images/vagrant-logo.png?raw=true "Vagrant Logo")

HashiCorp Vagrant provides the same, easy workflow regardless of your role as a developer, operator, or designer. It leverages a declarative configuration file which describes all your software requirements, packages, operating system configuration, users, and more.

### The Vagrantfile

`Vagrantfile`

[filename](../Vagrantfile.txt ':include :type=code ruby')

`vagrant up --provision`

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')


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
==> user.local.dev: Running provisioner: docker (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-35289-lj8d6b.sh
    ...
    user.local.dev: ++++ open http://localhost:8889 in your browser
    user.local.dev: ++++ you can also run below to get apache2 version from the docker container
    user.local.dev: ++++ vagrant ssh -c "docker exec -it apache2 /bin/bash -c 'apache2 -t -v'"
==> user.local.dev: Running provisioner: terraform (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-35289-gf77w9.sh
    ...
    user.local.dev: ++++ Terraform v0.12.18 already installed at /usr/local/bin/terraform
==> user.local.dev: Running provisioner: vault (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-35289-igtj7e.sh
    ...
    user.local.dev: ++++ Vault already installed and running
    user.local.dev: ++++ Vault http://localhost:8200/ui and enter the following codes displayed below
    ...
==> user.local.dev: Running provisioner: consul (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-35289-u3hjac.sh
    user.local.dev: Reading package lists...
    ...
    user.local.dev: ++++ Adding Consul KV data for Fabio Load Balancer Routes
    user.local.dev: Success! Data written to: fabio/config/vault
    user.local.dev: Success! Data written to: fabio/config/nomad
    user.local.dev: Success! Data written to: fabio/config/consul
    user.local.dev: ++++ Consul http://localhost:8500
==> user.local.dev: Running provisioner: nomad (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-35289-1s3k8i2.sh
    ...
    user.local.dev: ++++ Nomad already installed at /usr/local/bin/nomad
    user.local.dev: ++++ Nomad v0.10.2 (0d2d6e3dc5a171c21f8f31fa117c8a765eb4fc02)
    user.local.dev: ++++ cni-plugins already installed
    user.local.dev: ==> Loaded configuration from /etc/nomad/server.conf
    user.local.dev: ==> Starting Nomad agent...
    ...
==> user.local.dev: Running provisioner: packer (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-35289-18twg6l.sh
    ...
==> user.local.dev: Running provisioner: sentinel (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-35289-18qv6vf.sh
    ...
    user.local.dev: ++++ Sentinel Simulator v0.9.2 already installed at /usr/local/bin/sentinel
    user.local.dev: hour = 4
    user.local.dev: main = rule { hour >= 0 and hour < 12 }
    user.local.dev: ++++ cat /tmp/policy.sentinel
    user.local.dev: hour = 4
    user.local.dev: main = rule { hour >= 0 and hour < 12 }
    user.local.dev: ++++ sentinel apply /tmp/policy.sentinel
    user.local.dev: Pass
==> user.local.dev: Running provisioner: localstack (shell)...
    ...
==> user.local.dev: Running provisioner: docsify (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-35289-1du0q9e.sh
    ...
    user.local.dev: ++++ Docsify: http://localhost:3333/
```

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')