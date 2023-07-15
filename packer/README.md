# Packer

https://www.packer.io

![Packer Logo](images/packer-logo.png?raw=true "Packer Logo")

Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration. Packer is lightweight, runs on every major operating system, and is highly performant, creating machine images for multiple platforms in parallel.

Packer will build a Docker container, use the Shell and Ansible provisioners, Ansible will also connect to Vault to retrieve secrets using a Token.

[![Introduction to HashiCorp Packer](https://img.youtube.com/vi/r0I4TTO957w/maxresdefault.jpg)](https://www.youtube.com/watch?v=r0I4TTO957w)

https://learn.hashicorp.com/vault/getting-started/secrets-engines
https://docs.ansible.com/ansible/latest/plugins/lookup/hashi_vault.html

Packer Templates can be found in packer/packer/linux and packer/packer/windows

You can build local Windows and Ubuntu boxes with packer using these commands

You must be in the directory `packer`

Now you can run `./run.sh`

## Packer Templates

Packer uses the HashiCorp Configuration Language - HCL - designed to allow concise descriptions of the required steps to get to a build file.

### Ubuntu 22.04 Packer Template

`packer/linux/ubuntu/ubuntu-2204.pkr.hcl`

[filename](packer/linux/ubuntu/ubuntu-2204.pkr.hcl ':include :type=code')

### Windows 2019 Packer Template

`packer/windows/windowsserver/windows-2019.pkr.hcl`

[filename](packer/windows/windowsserver/windows-2019.pkr.hcl ':include :type=code')
## Packer Vagrant Provisioner

`packer.sh`

[filename](packer.sh ':include :type=code')
