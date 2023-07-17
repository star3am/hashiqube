# Packer

https://www.packer.io

![Packer Logo](images/packer-logo.png?raw=true "Packer Logo")

Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration. Packer is lightweight, runs on every major operating system, and is highly performant, creating machine images for multiple platforms in parallel.

Packer will build a Docker container, use the Shell and Ansible provisioners, Ansible will also connect to Vault to retrieve secrets using a Token.

Keeping track of base images can be challenging. In this whiteboard video, HashiCorp Co-Founder and CTO Armon Dadgar explains how HCP Packer forms the core of a multi-cloud golden image pipeline.

HashiCorp Packer allows you to codify and automate build pipelines for machine images in multiple formats. But how do you make these images discoverable and ensure only the correct versions are deployed to production?

HCP Packer, part of the HashiCorp Cloud Platform, provides a registry that tracks your image metadata and presents it to downstream processes through an API. Together with the Packer data source in the HCP provider for Terraform, this forms the foundation of a multi-cloud golden image pipeline to automate the lifecycle of images from build through deployment.

[![Introduction to HashiCorp Packer](images/maxresdefault.jpeg)](https://www.youtube.com/watch?v=r0I4TTO957w)

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
