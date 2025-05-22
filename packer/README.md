# Packer

<div align="center">
  <p><strong>Create identical machine images for multiple platforms from a single configuration</strong></p>
</div>

![Packer Logo](images/packer-logo.png?raw=true "Packer Logo")

## 🚀 Introduction

In this HashiQube DevOps lab, you will get hands-on experience with HashiCorp Packer.

Packer is an open source tool for creating identical machine images for multiple platforms from a single source configuration. It's lightweight, runs on every major operating system, and is highly performant, creating machine images for multiple platforms in parallel.

In this lab, Packer will build a Docker container, use the Shell and Ansible provisioners, and Ansible will connect to Vault to retrieve secrets using a Token.

[![Introduction to HashiCorp Packer](images/maxresdefault.jpeg)](https://www.youtube.com/watch?v=r0I4TTO957w)

## 💡 HCP Packer Cloud Features

Keeping track of base images can be challenging. HashiCorp Co-Founder and CTO Armon Dadgar explains how HCP Packer forms the core of a multi-cloud golden image pipeline.

HCP Packer, part of the HashiCorp Cloud Platform, provides a registry that tracks your image metadata and presents it to downstream processes through an API. Together with the Packer data source in the HCP provider for Terraform, this forms the foundation of a multi-cloud golden image pipeline to automate the lifecycle of images from build through deployment.

## 🛠️ Getting Started

Packer Templates can be found in these directories:

- `packer/packer/linux`
- `packer/packer/windows`

You can build local Windows and Ubuntu boxes with Packer using these steps:

1. Navigate to the Packer directory:

   ```bash
   cd packer
   ```

2. Run the build script:

   ```bash
   ./run.sh
   ```

## 📄 Packer Templates

Packer uses the HashiCorp Configuration Language (HCL), designed to allow concise descriptions of the required steps to get to a build file.

### Ubuntu 22.04 Packer Template

`packer/linux/ubuntu/ubuntu-2204.pkr.hcl`

```hcl
[filename](packer/linux/ubuntu/ubuntu-2204.pkr.hcl ':include :type=code')
```

### Windows 2019 Packer Template

`packer/windows/windowsserver/windows-2019.pkr.hcl`

```hcl
[filename](packer/windows/windowsserver/windows-2019.pkr.hcl ':include :type=code')
```

## ⚙️ Packer Vagrant Provisioner

The `packer.sh` script handles the installation and configuration of Packer:

```bash
[filename](packer.sh ':include :type=code')
```

## 🔗 Integration Points

Packer integrates with several other HashiCorp and third-party tools:

- **Vault**: For secrets management
  - [Vault Getting Started Guide](https://learn.hashicorp.com/vault/getting-started/secrets-engines)

- **Ansible**: For configuration management
  - [Ansible HashiCorp Vault Lookup Plugin](https://docs.ansible.com/ansible/latest/plugins/lookup/hashi_vault.html)

## 📚 Resources

- [Packer Official Website](https://www.packer.io)
- [Packer Documentation](https://www.packer.io/docs)
- [HCP Packer](https://cloud.hashicorp.com/products/packer)
- [Learn Packer](https://learn.hashicorp.com/packer)

[filename](packer.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')
