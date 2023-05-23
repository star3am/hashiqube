# terraform-hashicorp-hashiqube
Terraform Registry Module for HashiQube - a Development Lab using all the HashiCorp Products.

This repo contains a [Terraform](https://www.terraform.io/) module for provisioning [HashiQube](https://hashiqube.com) <br />
A __Development__ lab running all [HashiCorp](https://www.hashicorp.com/) products.

__DO NOT USE HASHIQUBE IN PRODUCTION__

## Introduction

Hello friends!

Hashicorp clustered Consul, Nomad and Vault HA in GCP, AWS and Azure using Terraform.

Last year I started learning about #Hashicorp products, and to help me do that, I created a VM or Docker container running all the Hashicorp products, you can read more about HashiQube the Development Lab that runs all Hashicorp products here:
[HashiQube at HashiTalks 2020](https://www.hashicorp.com/resources/hashiqube-a-development-lab-using-all-the-hashicorp-products/)

[HashiQube Website](https://hashiqube.com)

This year I wanted to improve my Terraform knowledge while studying for my Terraform Associate Exam and I decided to try spin up HashiQube on the Clouds, GCP, Azure and AWS using Terraform.

I have written a Terraform Registry module that can help you do exactly that, https://registry.terraform.io/modules/star3am/hashiqube/hashicorp/latest

This module can launch a Vault, Consul and Nomad (Clustered) on all clouds or just 1 if you only have 1 Cloud account.

Give it a try and most of all have fun with this module, your feedback is always greatly appreciated!

#Hashicorp #Vault #Consul #Nomad #Waypoint #Boundary #HashiQube #Kifftech #Curious

![Hashiqube Integrations](images/logo-qube.png?raw=true "Hashiqube Integrations")

## Quickstart
- Download and Install VSCode https://code.visualstudio.com/
- Install the VSCode Remote Containers extension https://code.visualstudio.com/docs/devcontainers/containers
- Install Docker Desktop

Everything you need is done via the Dockerfile, and once you open this project folder with VSCode Dev Containers, you will be dropped into a container built of the Dockerfile with Terraform already installed. 

You simple need to configure your Cloud authentication, and this is done: 
- AWS ~/.aws/config
- GCP ~/.gcp/credentials.json
- Azure with `az login` (The credentials are then passed into the container via the ENV variables in the docker-compose.yml file) 

![VSCode Dev Containers](images/vscode-dev-containers.png?raw=true "VSCode Dev Containers")

## Using Dev Containers also called Remote Containers with VSCode 

https://code.visualstudio.com/docs/devcontainers/containers

The Visual Studio Code Dev Containers extension lets you use a container as a full-featured development environment. It allows you to open any folder inside (or mounted into) a container and take advantage of Visual Studio Code's full feature set. A devcontainer.json file in your project tells VS Code how to access (or create) a development container with a well-defined tool and runtime stack. This container can be used to run an application or to separate tools, libraries, or runtimes needed for working with a codebase.

Workspace files are mounted from the local file system or copied or cloned into the container. Extensions are installed and run inside the container, where they have full access to the tools, platform, and file system. This means that you can seamlessly switch your entire development environment just by connecting to a different container.

## Download and Install Popular VSCode Extensions 

Also install these popular Extensions to help you get started: 

- Azure Terraform Extension
https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureterraform

- Terraform Extension
https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform

- Install Git History Extension
https://marketplace.visualstudio.com/items?itemName=donjayamanne.githistory

- Install GitLens Extension
https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens

- YAML Extension
https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml

- Docker Remote Extension (Dev Containers / Remote Containers)
https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers

- AWS Toolkit
https://aws.amazon.com/visualstudiocode/

- AWS CloudFormation Extension
https://marketplace.visualstudio.com/items?itemName=aws-scripting-guy.cform

- Dracula Dark Theme
https://marketplace.visualstudio.com/items?itemName=dracula-theme.theme-dracula

- Live Share Extension 
https://marketplace.visualstudio.com/items?itemName=MS-vsliveshare.vsliveshare-pack

## Links
HashiCorp blog post: https://www.hashicorp.com/resources/hashiqube-a-development-lab-using-all-the-hashicorp-products <br />
HashiQube website: https://hashiqube.com <br />
HashiQube github: https://github.com/star3am/hashiqube <br />
HashiQube youtube: https://www.youtube.com/watch?v=6jGDAGWaFiw <br />
HashiQube medium: https://medium.com/search?q=hashiqube

## Purpose
HashiQube has been created to help developers and engineers to get up to speed with HashiCorp products. It can be used for development, testing or training. HashiQube gives all interested parties the empowerment to deploy these tools in a way covers multiple use cases effectively providing a 'concept to completion' testbed using open-source HashiCorp products.

## HashiQube runs all HashiCorp's products and more
![HashiQube](images/thestack.png?raw=true "HashiQube")

- [What is a Terraform module](#what-is-a-terraform-module)
- [How do you use this module](#how-do-you-use-this-module)
    - [Prerequisites](#prerequisites)
    - [Module Inputs](#inputs)
    - [Module Outputs](#outputs)

## What is a Terraform module
A Terraform "module" refers to a self-contained package of Terraform configurations that are managed as a group.
For more information around modules refer to the Terraform [documentation](https://www.terraform.io/docs/modules/index.html)

## How do you use this module

To use this module You have 2 options

1) You clone this repository and edit the variables.tf file or rename terraform.auto.tfvars.example to terraform.auto.tfvars and edit the values.

2) You can look for an example in the examples folder, this will use the module from the Terraform Registry

In both cases you only need to edit the variables.tf or terraform.auto.tfvars

I've tried to include the batteries, so all you need to do is enable your cloud (or all 3) in `variables.tf`

```
variable "deploy_to_aws" {
  type        = bool
  default     = true
  description = "Deploy Hashiqube on AWS"
}

variable "deploy_to_gcp" {
  type        = bool
  default     = true
  description = "Deploy Hashiqube on GCP"
}

variable "deploy_to_azure" {
  type        = bool
  default     = true
  description = "Deploy Hashiqube on Azure"
}
```

You can then apply this Terraform configuration via:

`terraform init -upgrade`

```
Upgrading modules...
- aws-hashiqube in modules/aws-hashiqube
- azure-hashiqube in modules/azure-hashiqube
- gcp-hashiqube in modules/gcp-hashiqube

Initializing the backend...

Initializing provider plugins...
- Finding latest version of hashicorp/null...
- Finding latest version of hashicorp/external...
- Finding hashicorp/google versions matching "~> 4.65"...
- Finding hashicorp/aws versions matching "~> 4.67"...
- Finding hashicorp/azurerm versions matching "3.57.0"...
- Using previously-installed hashicorp/null v3.2.1
- Using previously-installed hashicorp/external v2.3.1
- Installing hashicorp/google v4.66.0...
- Installed hashicorp/google v4.66.0 (signed by HashiCorp)
- Using previously-installed hashicorp/aws v4.67.0
- Using previously-installed hashicorp/azurerm v3.57.0

Terraform has made some changes to the provider dependency selections recorded
in the .terraform.lock.hcl file. Review those changes and commit them to your
version control system if they represent changes you intended to make.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

`terraform apply`

```
Terraform used the selected providers to generate the following execution plan. Resource actions are
indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # null_resource.hashiqube will be created
  + resource "null_resource" "hashiqube" {
      + id       = (known after apply)
      + triggers = {
          + "deploy_to_aws"   = "true"
          + "deploy_to_azure" = "true"
          + "deploy_to_gcp"   = "true"
          + "my_ipaddress"    = "101.189.211.xxx"
        }
    }

  # module.aws-hashiqube[0].aws_eip.hashiqube will be created
  + resource "aws_eip" "hashiqube" {
      + allocation_id        = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = (known after apply)
      + id                   = (known after apply)
      + instance             = (known after apply)
      + network_border_group = (known after apply)
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + tags_all             = (known after apply)
      + vpc                  = true
    }

  # module.aws-hashiqube[0].aws_eip_association.eip_assoc will be created
  + resource "aws_eip_association" "eip_assoc" {
      + allocation_id        = (known after apply)
      + id                   = (known after apply)
      + instance_id          = (known after apply)
      + network_interface_id = (known after apply)
      + private_ip_address   = (known after apply)
      + public_ip            = (known after apply)
    }

  # module.aws-hashiqube[0].aws_iam_instance_profile.hashiqube will be created
  + resource "aws_iam_instance_profile" "hashiqube" {
      + arn         = (known after apply)
      + create_date = (known after apply)
      + id          = (known after apply)
      + name        = "hashiqube"
      + name_prefix = (known after apply)
      + path        = "/"
      + role        = "hashiqube"
      + tags_all    = (known after apply)
      + unique_id   = (known after apply)
    }

  # module.aws-hashiqube[0].aws_iam_role.hashiqube will be created
  + resource "aws_iam_role" "hashiqube" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "ec2.amazonaws.com"
                        }
                      + Sid       = ""
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "hashiqube"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + role_last_used        = (known after apply)
      + tags_all              = (known after apply)
      + unique_id             = (known after apply)

      + inline_policy {
          + name   = (known after apply)
          + policy = (known after apply)
        }
    }

  # module.aws-hashiqube[0].aws_iam_role_policy.hashiqube will be created
  + resource "aws_iam_role_policy" "hashiqube" {
      + id     = (known after apply)
      + name   = "hashiqube"
      + policy = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = [
                          + "ec2:Describe*",
                        ]
                      + Effect   = "Allow"
                      + Resource = "*"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + role   = (known after apply)
    }

  # module.aws-hashiqube[0].aws_instance.hashiqube will be created
  + resource "aws_instance" "hashiqube" {
      + ami                                  = "ami-0d02292614a3b0df1"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = "hashiqube"
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.medium"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "hashiqube"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = [
          + "hashiqube",
        ]
      + source_dest_check                    = true
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "hashiqube"
        }
      + tags_all                             = {
          + "Name" = "hashiqube"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + capacity_reservation_specification {
          + capacity_reservation_preference = (known after apply)

          + capacity_reservation_target {
              + capacity_reservation_id                 = (known after apply)
              + capacity_reservation_resource_group_arn = (known after apply)
            }
        }

      + cpu_options {
          + amd_sev_snp      = (known after apply)
          + core_count       = (known after apply)
          + threads_per_core = (known after apply)
        }

      + ebs_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + snapshot_id           = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }

      + enclave_options {
          + enabled = (known after apply)
        }

      + ephemeral_block_device {
          + device_name  = (known after apply)
          + no_device    = (known after apply)
          + virtual_name = (known after apply)
        }

      + maintenance_options {
          + auto_recovery = (known after apply)
        }

      + metadata_options {
          + http_endpoint               = (known after apply)
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
          + instance_metadata_tags      = (known after apply)
        }

      + network_interface {
          + delete_on_termination = (known after apply)
          + device_index          = (known after apply)
          + network_card_index    = (known after apply)
          + network_interface_id  = (known after apply)
        }

      + private_dns_name_options {
          + enable_resource_name_dns_a_record    = (known after apply)
          + enable_resource_name_dns_aaaa_record = (known after apply)
          + hostname_type                        = (known after apply)
        }

      + root_block_device {
          + delete_on_termination = (known after apply)
          + device_name           = (known after apply)
          + encrypted             = (known after apply)
          + iops                  = (known after apply)
          + kms_key_id            = (known after apply)
          + tags                  = (known after apply)
          + throughput            = (known after apply)
          + volume_id             = (known after apply)
          + volume_size           = (known after apply)
          + volume_type           = (known after apply)
        }
    }

  # module.aws-hashiqube[0].aws_key_pair.hashiqube will be created
  + resource "aws_key_pair" "hashiqube" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "hashiqube"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAd1E2uJrIFr8PVIMiGvCCdwpL2UHjTz3QZUL361QCsZxcChAR1/DOvKygCnGEqZ2p4aBvHrEBiyHt1POQJzhtKzG4o14zmzZ5prBHFiyhFdTeqKHtYqgKVhrYPkgALLWZFcl3rSSBZpWTli3NpkfAv98aTyCrljJohUJdJkeL3RxuX6gHN"
      + tags_all        = (known after apply)
    }

  # module.aws-hashiqube[0].aws_security_group.hashiqube will be created
  + resource "aws_security_group" "hashiqube" {
      + arn                    = (known after apply)
      + description            = "Managed by Terraform"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "101.189.211.xxx/32",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 65535
            },
          + {
              + cidr_blocks      = [
                  + "101.189.211.xxx/32",
                ]
              + description      = ""
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "udp"
              + security_groups  = []
              + self             = false
              + to_port          = 65535
            },
        ]
      + name                   = "hashiqube"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

  # module.aws-hashiqube[0].aws_security_group_rule.aws_hashiqube[0] will be created
  + resource "aws_security_group_rule" "aws_hashiqube" {
      + cidr_blocks              = (known after apply)
      + from_port                = 0
      + id                       = (known after apply)
      + protocol                 = "-1"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 65535
      + type                     = "ingress"
    }

  # module.aws-hashiqube[0].aws_security_group_rule.azure_hashiqube[0] will be created
  + resource "aws_security_group_rule" "azure_hashiqube" {
      + cidr_blocks              = (known after apply)
      + from_port                = 0
      + id                       = (known after apply)
      + protocol                 = "-1"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 65535
      + type                     = "ingress"
    }

  # module.aws-hashiqube[0].aws_security_group_rule.gcp_hashiqube[0] will be created
  + resource "aws_security_group_rule" "gcp_hashiqube" {
      + cidr_blocks              = (known after apply)
      + from_port                = 0
      + id                       = (known after apply)
      + protocol                 = "-1"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 65535
      + type                     = "ingress"
    }

  # module.aws-hashiqube[0].aws_security_group_rule.whitelist_cidr[0] will be created
  + resource "aws_security_group_rule" "whitelist_cidr" {
      + cidr_blocks              = [
          + "20.191.210.xxx/32",
        ]
      + from_port                = 0
      + id                       = (known after apply)
      + protocol                 = "-1"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 65535
      + type                     = "ingress"
    }

  # module.aws-hashiqube[0].null_resource.hashiqube will be created
  + resource "null_resource" "hashiqube" {
      + id       = (known after apply)
      + triggers = {
          + "azure_hashiqube_ip" = (known after apply)
          + "deploy_to_aws"      = "true"
          + "deploy_to_azure"    = "true"
          + "deploy_to_gcp"      = "true"
          + "gcp_hashiqube_ip"   = (known after apply)
          + "my_ipaddress"       = "101.189.211.xxx"
          + "ssh_public_key"     = "~/.ssh/id_rsa.pub"
          + "vault_enabled"      = "true"
          + "vault_version"      = "1.4.1"
          + "whitelist_cidr"     = "20.191.210.xxx/32"
        }
    }

  # module.azure-hashiqube[0].azurerm_linux_virtual_machine.hashiqube will be created
  + resource "azurerm_linux_virtual_machine" "hashiqube" {
      + admin_username                  = "ubuntu"
      + allow_extension_operations      = true
      + computer_name                   = (known after apply)
      + custom_data                     = (sensitive value)
      + disable_password_authentication = true
      + extensions_time_budget          = "PT1H30M"
      + id                              = (known after apply)
      + location                        = "australiaeast"
      + max_bid_price                   = -1
      + name                            = "hashiqube"
      + network_interface_ids           = (known after apply)
      + patch_assessment_mode           = "ImageDefault"
      + patch_mode                      = "ImageDefault"
      + platform_fault_domain           = -1
      + priority                        = "Regular"
      + private_ip_address              = (known after apply)
      + private_ip_addresses            = (known after apply)
      + provision_vm_agent              = true
      + public_ip_address               = (known after apply)
      + public_ip_addresses             = (known after apply)
      + resource_group_name             = "hashiqube"
      + size                            = "Standard_DS1_v2"
      + tags                            = {
          + "environment" = "hashiqube"
        }
      + virtual_machine_id              = (known after apply)

      + admin_ssh_key {
          + public_key = <<-EOT
                ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAd1E2uJrIFr8PVIMiGvCCdwpL2UDOvKygCnGEqZ2p4aBvHrEBiyHt1POQJzhtKzG4o14zmzZ5prBHFiyhFdTeqKHtYqgKVhrYPkgALLWZFcl3rSSBZpWTli3NpkfAv98aTyCrljJohUJdJkeL3RxuX6gHN
            EOT
          + username   = "ubuntu"
        }

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + name                      = (known after apply)
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + source_image_reference {
          + offer     = "0001-com-ubuntu-server-focal"
          + publisher = "Canonical"
          + sku       = "20_04-lts-gen2"
          + version   = "latest"
        }

      + termination_notification {
          + enabled = (known after apply)
          + timeout = (known after apply)
        }
    }

  # module.azure-hashiqube[0].azurerm_network_interface.hashiqube will be created
  + resource "azurerm_network_interface" "hashiqube" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "australiaeast"
      + mac_address                   = (known after apply)
      + name                          = "hashiqube"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "hashiqube"
      + tags                          = {
          + "environment" = "hashiqube"
        }
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + name                                               = "hashiqube"
          + primary                                            = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = "Dynamic"
          + private_ip_address_version                         = "IPv4"
          + public_ip_address_id                               = (known after apply)
          + subnet_id                                          = (known after apply)
        }
    }

  # module.azure-hashiqube[0].azurerm_network_security_group.aws_hashiqube_ip[0] will be created
  + resource "azurerm_network_security_group" "aws_hashiqube_ip" {
      + id                  = (known after apply)
      + location            = "australiaeast"
      + name                = "aws_hashiqube_ip"
      + resource_group_name = "hashiqube"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = ""
              + destination_address_prefixes               = (known after apply)
              + destination_application_security_group_ids = []
              + destination_port_range                     = "*"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "aws_hashiqube_ip"
              + priority                                   = 1003
              + protocol                                   = "Tcp"
              + source_address_prefix                      = ""
              + source_address_prefixes                    = (known after apply)
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
      + tags                = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure-hashiqube[0].azurerm_network_security_group.azure_hashiqube_ip[0] will be created
  + resource "azurerm_network_security_group" "azure_hashiqube_ip" {
      + id                  = (known after apply)
      + location            = "australiaeast"
      + name                = "azure_hashiqube_ip"
      + resource_group_name = "hashiqube"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = ""
              + destination_address_prefixes               = (known after apply)
              + destination_application_security_group_ids = []
              + destination_port_range                     = "*"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "azure_hashiqube_ip"
              + priority                                   = 1002
              + protocol                                   = "Tcp"
              + source_address_prefix                      = ""
              + source_address_prefixes                    = (known after apply)
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
      + tags                = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure-hashiqube[0].azurerm_network_security_group.gcp_hashiqube_ip[0] will be created
  + resource "azurerm_network_security_group" "gcp_hashiqube_ip" {
      + id                  = (known after apply)
      + location            = "australiaeast"
      + name                = "gcp_hashiqube_ip"
      + resource_group_name = "hashiqube"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = ""
              + destination_address_prefixes               = (known after apply)
              + destination_application_security_group_ids = []
              + destination_port_range                     = "*"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "gcp_hashiqube_ip"
              + priority                                   = 1004
              + protocol                                   = "Tcp"
              + source_address_prefix                      = ""
              + source_address_prefixes                    = (known after apply)
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
      + tags                = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure-hashiqube[0].azurerm_network_security_group.my_ipaddress will be created
  + resource "azurerm_network_security_group" "my_ipaddress" {
      + id                  = (known after apply)
      + location            = "australiaeast"
      + name                = "hashiqube"
      + resource_group_name = "hashiqube"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = ""
              + destination_address_prefixes               = (known after apply)
              + destination_application_security_group_ids = []
              + destination_port_range                     = "*"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "myipaddress"
              + priority                                   = 1001
              + protocol                                   = "Tcp"
              + source_address_prefix                      = ""
              + source_address_prefixes                    = [
                  + "101.189.211.xxx/32",
                ]
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
      + tags                = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure-hashiqube[0].azurerm_network_security_group.whitelist_cidr[0] will be created
  + resource "azurerm_network_security_group" "whitelist_cidr" {
      + id                  = (known after apply)
      + location            = "australiaeast"
      + name                = "whitelist_cidr"
      + resource_group_name = "hashiqube"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = ""
              + destination_address_prefixes               = (known after apply)
              + destination_application_security_group_ids = []
              + destination_port_range                     = "*"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "whitelist_cidr"
              + priority                                   = 1005
              + protocol                                   = "Tcp"
              + source_address_prefix                      = ""
              + source_address_prefixes                    = [
                  + "20.191.210.171/32",
                ]
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
      + tags                = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure-hashiqube[0].azurerm_public_ip.hashiqube will be created
  + resource "azurerm_public_ip" "hashiqube" {
      + allocation_method       = "Static"
      + ddos_protection_mode    = "VirtualNetworkInherited"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "australiaeast"
      + name                    = "hashiqube"
      + resource_group_name     = "hashiqube"
      + sku                     = "Basic"
      + sku_tier                = "Regional"
      + tags                    = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure-hashiqube[0].azurerm_resource_group.hashiqube will be created
  + resource "azurerm_resource_group" "hashiqube" {
      + id       = (known after apply)
      + location = "australiaeast"
      + name     = "hashiqube"
      + tags     = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure-hashiqube[0].azurerm_subnet.hashiqube will be created
  + resource "azurerm_subnet" "hashiqube" {
      + address_prefixes                               = [
          + "10.0.1.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = (known after apply)
      + enforce_private_link_service_network_policies  = (known after apply)
      + id                                             = (known after apply)
      + name                                           = "hashiqube"
      + private_endpoint_network_policies_enabled      = (known after apply)
      + private_link_service_network_policies_enabled  = (known after apply)
      + resource_group_name                            = "hashiqube"
      + virtual_network_name                           = "hashiqube"
    }

  # module.azure-hashiqube[0].azurerm_virtual_network.hashiqube will be created
  + resource "azurerm_virtual_network" "hashiqube" {
      + address_space       = [
          + "10.0.0.0/16",
        ]
      + dns_servers         = (known after apply)
      + guid                = (known after apply)
      + id                  = (known after apply)
      + location            = "australiaeast"
      + name                = "hashiqube"
      + resource_group_name = "hashiqube"
      + subnet              = (known after apply)
      + tags                = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure-hashiqube[0].null_resource.hashiqube will be created
  + resource "null_resource" "hashiqube" {
      + id       = (known after apply)
      + triggers = {
          + "aws_hashiqube_ip"    = (known after apply)
          + "azure_instance_type" = "Standard_DS1_v2"
          + "azure_region"        = "Australia East"
          + "deploy_to_aws"       = "true"
          + "deploy_to_azure"     = "true"
          + "deploy_to_gcp"       = "true"
          + "gcp_hashiqube_ip"    = (known after apply)
          + "my_ipaddress"        = "101.189.211.xxx"
          + "ssh_public_key"      = "~/.ssh/id_rsa.pub"
          + "vault_enabled"       = "true"
          + "vault_version"       = "1.4.1"
          + "whitelist_cidr"      = "20.191.210.xxx/32"
        }
    }

  # module.gcp-hashiqube[0].google_compute_address.hashiqube will be created
  + resource "google_compute_address" "hashiqube" {
      + address            = (known after apply)
      + address_type       = "EXTERNAL"
      + creation_timestamp = (known after apply)
      + id                 = (known after apply)
      + name               = "hashiqube"
      + network_tier       = (known after apply)
      + project            = (known after apply)
      + purpose            = (known after apply)
      + region             = (known after apply)
      + self_link          = (known after apply)
      + subnetwork         = (known after apply)
      + users              = (known after apply)
    }

  # module.gcp-hashiqube[0].google_compute_firewall.aws-hashiqube_ip[0] will be created
  + resource "google_compute_firewall" "aws-hashiqube_ip" {
      + creation_timestamp = (known after apply)
      + destination_ranges = (known after apply)
      + direction          = (known after apply)
      + enable_logging     = (known after apply)
      + id                 = (known after apply)
      + name               = "aws-hashiqube-ip"
      + network            = "default"
      + priority           = 1000
      + project            = "riaan-nolan-xxx"
      + self_link          = (known after apply)
      + source_ranges      = (known after apply)

      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "tcp"
        }
      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "udp"
        }
    }

  # module.gcp-hashiqube[0].google_compute_firewall.azure_hashiqube_ip[0] will be created
  + resource "google_compute_firewall" "azure_hashiqube_ip" {
      + creation_timestamp = (known after apply)
      + destination_ranges = (known after apply)
      + direction          = (known after apply)
      + enable_logging     = (known after apply)
      + id                 = (known after apply)
      + name               = "azure-hashiqube-ip"
      + network            = "default"
      + priority           = 1000
      + project            = "riaan-nolan-xxx"
      + self_link          = (known after apply)
      + source_ranges      = (known after apply)

      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "tcp"
        }
      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "udp"
        }
    }

  # module.gcp-hashiqube[0].google_compute_firewall.gcp_hashiqube_ip[0] will be created
  + resource "google_compute_firewall" "gcp_hashiqube_ip" {
      + creation_timestamp = (known after apply)
      + destination_ranges = (known after apply)
      + direction          = (known after apply)
      + enable_logging     = (known after apply)
      + id                 = (known after apply)
      + name               = "gcp-hashiqube-ip"
      + network            = "default"
      + priority           = 1000
      + project            = "riaan-nolan-xxx"
      + self_link          = (known after apply)
      + source_ranges      = (known after apply)

      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "tcp"
        }
      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "udp"
        }
    }

  # module.gcp-hashiqube[0].google_compute_firewall.my_ipaddress will be created
  + resource "google_compute_firewall" "my_ipaddress" {
      + creation_timestamp = (known after apply)
      + destination_ranges = (known after apply)
      + direction          = (known after apply)
      + enable_logging     = (known after apply)
      + id                 = (known after apply)
      + name               = "hashiqube-my-ipaddress"
      + network            = "default"
      + priority           = 1000
      + project            = "riaan-nolan-xxx"
      + self_link          = (known after apply)
      + source_ranges      = [
          + "101.189.211.47/32",
        ]

      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "tcp"
        }
      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "udp"
        }
    }

  # module.gcp-hashiqube[0].google_compute_firewall.whitelist_cidr[0] will be created
  + resource "google_compute_firewall" "whitelist_cidr" {
      + creation_timestamp = (known after apply)
      + destination_ranges = (known after apply)
      + direction          = (known after apply)
      + enable_logging     = (known after apply)
      + id                 = (known after apply)
      + name               = "whitelist-cidr"
      + network            = "default"
      + priority           = 1000
      + project            = "riaan-nolan-xxx"
      + self_link          = (known after apply)
      + source_ranges      = [
          + "20.191.210.171/32",
        ]

      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "tcp"
        }
      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "udp"
        }
    }

  # module.gcp-hashiqube[0].google_compute_instance_template.hashiqube will be created
  + resource "google_compute_instance_template" "hashiqube" {
      + can_ip_forward          = false
      + description             = "hashiqube"
      + id                      = (known after apply)
      + instance_description    = "hashiqube"
      + machine_type            = "n1-standard-1"
      + metadata                = {
          + "ssh-keys" = <<-EOT
                ubuntu:ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAd1E2uJrIFr8PVIMiGvCCdwpL2UDOvKygCnGEqZ2p4aBvHrEBiyHt1POQJzhtKzG4o14zmzZ5prBHFiyhFdTeqKHtYqgKVhrYPkgALLWZFcl3rSSBZpWTli3NpkfAv98aTyCrljJohUJdJkeL3RxuX6gHN
            EOT
        }
      + metadata_fingerprint    = (known after apply)
      + metadata_startup_script = (known after apply)
      + name                    = (known after apply)
      + name_prefix             = "hashiqube"
      + project                 = (known after apply)
      + region                  = (known after apply)
      + self_link               = (known after apply)
      + self_link_unique        = (known after apply)
      + tags                    = [
          + "hashiqube",
        ]
      + tags_fingerprint        = (known after apply)

      + confidential_instance_config {
          + enable_confidential_compute = (known after apply)
        }

      + disk {
          + auto_delete  = true
          + boot         = true
          + device_name  = (known after apply)
          + disk_size_gb = 16
          + disk_type    = "pd-standard"
          + interface    = (known after apply)
          + mode         = (known after apply)
          + source_image = "ubuntu-os-cloud/ubuntu-2004-lts"
          + type         = (known after apply)
        }

      + network_interface {
          + ipv6_access_type   = (known after apply)
          + name               = (known after apply)
          + network            = (known after apply)
          + stack_type         = (known after apply)
          + subnetwork         = "https://www.googleapis.com/compute/v1/projects/riaan-nolan-xxx/regions/australia-southeast1/subnetworks/default"
          + subnetwork_project = (known after apply)

          + access_config {
              + nat_ip                 = (known after apply)
              + network_tier           = (known after apply)
              + public_ptr_domain_name = (known after apply)
            }
        }

      + scheduling {
          + automatic_restart   = true
          + on_host_maintenance = "MIGRATE"
          + preemptible         = false
          + provisioning_model  = (known after apply)
        }

      + service_account {
          + email  = (known after apply)
          + scopes = [
              + "https://www.googleapis.com/auth/compute.readonly",
              + "https://www.googleapis.com/auth/devstorage.read_write",
              + "https://www.googleapis.com/auth/userinfo.email",
            ]
        }
    }

  # module.gcp-hashiqube[0].google_compute_region_instance_group_manager.hashiqube will be created
  + resource "google_compute_region_instance_group_manager" "hashiqube" {
      + base_instance_name               = "hashiqube"
      + distribution_policy_target_shape = (known after apply)
      + distribution_policy_zones        = [
          + "australia-southeast1-a",
          + "australia-southeast1-b",
          + "australia-southeast1-c",
        ]
      + fingerprint                      = (known after apply)
      + id                               = (known after apply)
      + instance_group                   = (known after apply)
      + list_managed_instances_results   = "PAGELESS"
      + name                             = "hashiqube"
      + project                          = (known after apply)
      + region                           = "australia-southeast1"
      + self_link                        = (known after apply)
      + status                           = (known after apply)
      + target_size                      = 1
      + wait_for_instances               = false
      + wait_for_instances_status        = "STABLE"

      + update_policy {
          + max_surge_fixed       = 3
          + max_unavailable_fixed = 0
          + minimal_action        = "REPLACE"
          + type                  = "PROACTIVE"
        }

      + version {
          + instance_template = (known after apply)
          + name              = "hashiqube"
        }
    }

  # module.gcp-hashiqube[0].google_project_iam_member.hashiqube will be created
  + resource "google_project_iam_member" "hashiqube" {
      + etag    = (known after apply)
      + id      = (known after apply)
      + member  = (known after apply)
      + project = "riaan-nolan-xxx"
      + role    = "roles/compute.networkViewer"
    }

  # module.gcp-hashiqube[0].google_service_account.hashiqube will be created
  + resource "google_service_account" "hashiqube" {
      + account_id   = "sa-consul-compute-prod"
      + disabled     = false
      + display_name = "hashiqube"
      + email        = (known after apply)
      + id           = (known after apply)
      + member       = (known after apply)
      + name         = (known after apply)
      + project      = "riaan-nolan-xxx"
      + unique_id    = (known after apply)
    }

  # module.gcp-hashiqube[0].null_resource.hashiqube will be created
  + resource "null_resource" "hashiqube" {
      + id       = (known after apply)
      + triggers = {
          + "aws_hashiqube_ip"   = (known after apply)
          + "azure_hashiqube_ip" = (known after apply)
          + "deploy_to_aws"      = "true"
          + "deploy_to_azure"    = "true"
          + "deploy_to_gcp"      = "true"
          + "gcp_credentials"    = "~/.gcp/credentials.json"
          + "gcp_project"        = "riaan-nolan-xxx"
          + "my_ipaddress"       = "101.189.211.xxx"
          + "ssh_public_key"     = "~/.ssh/id_rsa.pub"
          + "vault_enabled"      = "true"
          + "vault_version"      = "1.4.1"
          + "whitelist_cidr"     = "20.191.210.xxx/32"
        }
    }

Plan: 37 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + aaa_welcome                = <<-EOT
        Your HashiQube instance is busy launching, usually this takes ~5 minutes.
        Below are some links to open in your browser, and commands you can copy and paste in a terminal to login via SSH into your HashiQube instance.
        Thank you for using this module, you are most welcome to fork this repository to make it your own.
        ** DO NOT USE THIS IN PRODUCTION **
    EOT
  + aab_instructions           = <<-EOT
        Use the Hashiqube SSH output below to login to your instance
        To get Vault Shamir keys and Root token do "sudo cat /etc/vault/init.file"
    EOT
  + aws_hashiqube-boundary     = (known after apply)
  + aws_hashiqube-consul       = (known after apply)
  + aws_hashiqube-fabio-lb     = (known after apply)
  + aws_hashiqube-fabio-ui     = (known after apply)
  + aws_hashiqube-nomad        = (known after apply)
  + aws_hashiqube-ssh          = (known after apply)
  + aws_hashiqube-traefik-lb   = (known after apply)
  + aws_hashiqube-traefik-ui   = (known after apply)
  + aws_hashiqube-vault        = (known after apply)
  + aws_hashiqube-waypoint     = (known after apply)
  + aws_hashiqube_ip           = (known after apply)
  + azure_hashiqube-boundary   = (known after apply)
  + azure_hashiqube-consul     = (known after apply)
  + azure_hashiqube-fabio-lb   = (known after apply)
  + azure_hashiqube-fabio-ui   = (known after apply)
  + azure_hashiqube-nomad      = (known after apply)
  + azure_hashiqube-ssh        = (known after apply)
  + azure_hashiqube-traefik-lb = (known after apply)
  + azure_hashiqube-traefik-ui = (known after apply)
  + azure_hashiqube-vault      = (known after apply)
  + azure_hashiqube-waypoint   = (known after apply)
  + azure_hashiqube_ip         = (known after apply)
  + gcp_hashiqube-boundary     = (known after apply)
  + gcp_hashiqube-consul       = (known after apply)
  + gcp_hashiqube-fabio-lb     = (known after apply)
  + gcp_hashiqube-fabio-ui     = (known after apply)
  + gcp_hashiqube-nomad        = (known after apply)
  + gcp_hashiqube-ssh          = (known after apply)
  + gcp_hashiqube-traefik-lb   = (known after apply)
  + gcp_hashiqube-traefik-ui   = (known after apply)
  + gcp_hashiqube-vault        = (known after apply)
  + gcp_hashiqube-waypoint     = (known after apply)
  + gcp_hashiqube_ip           = (known after apply)
  + your_ipaddress             = "101.189.211.xxx"
null_resource.hashiqube: Creating...
null_resource.hashiqube: Creation complete after 0s [id=4786748456103842066]
module.aws-hashiqube[0].aws_key_pair.hashiqube: Creating...
module.aws-hashiqube[0].aws_iam_role.hashiqube: Creating...
module.aws-hashiqube[0].aws_eip.hashiqube: Creating...
module.aws-hashiqube[0].aws_security_group.hashiqube: Creating...
module.aws-hashiqube[0].aws_key_pair.hashiqube: Creation complete after 0s [id=hashiqube]
module.aws-hashiqube[0].aws_eip.hashiqube: Creation complete after 1s [id=eipalloc-0bc3714f1aab61ada]
module.gcp-hashiqube[0].google_service_account.hashiqube: Creating...
module.gcp-hashiqube[0].google_compute_firewall.aws-hashiqube_ip[0]: Creating...
module.gcp-hashiqube[0].google_compute_firewall.my_ipaddress: Creating...
module.gcp-hashiqube[0].google_compute_firewall.whitelist_cidr[0]: Creating...
module.gcp-hashiqube[0].google_compute_address.hashiqube: Creating...
module.aws-hashiqube[0].aws_security_group.hashiqube: Creation complete after 2s [id=sg-03ad8f607da0679ed]
module.aws-hashiqube[0].aws_security_group_rule.whitelist_cidr[0]: Creating...
module.aws-hashiqube[0].aws_security_group_rule.aws_hashiqube[0]: Creating...
module.aws-hashiqube[0].aws_iam_role.hashiqube: Creation complete after 2s [id=hashiqube]
module.aws-hashiqube[0].aws_iam_role_policy.hashiqube: Creating...
module.aws-hashiqube[0].aws_iam_instance_profile.hashiqube: Creating...
module.gcp-hashiqube[0].google_service_account.hashiqube: Creation complete after 1s [id=projects/riaan-nolan-xxx/serviceAccounts/sa-consul-compute-prod@riaan-nolan-xxx.iam.gserviceaccount.com]
module.gcp-hashiqube[0].google_project_iam_member.hashiqube: Creating...
module.aws-hashiqube[0].aws_security_group_rule.whitelist_cidr[0]: Creation complete after 1s [id=sgrule-4015781165]
module.aws-hashiqube[0].aws_security_group_rule.aws_hashiqube[0]: Creation complete after 1s [id=sgrule-956318792]
module.aws-hashiqube[0].aws_iam_role_policy.hashiqube: Creation complete after 1s [id=hashiqube:hashiqube]
module.gcp-hashiqube[0].google_compute_address.hashiqube: Creation complete after 3s [id=projects/riaan-nolan-xxx/regions/australia-southeast1/addresses/hashiqube]
module.azure-hashiqube[0].null_resource.hashiqube: Creating...
module.gcp-hashiqube[0].google_compute_firewall.gcp_hashiqube_ip[0]: Creating...
module.aws-hashiqube[0].aws_security_group_rule.gcp_hashiqube[0]: Creating...
module.azure-hashiqube[0].null_resource.hashiqube: Creation complete after 0s [id=3293639629331471405]
module.aws-hashiqube[0].aws_security_group_rule.gcp_hashiqube[0]: Creation complete after 0s [id=sgrule-150453245]
module.aws-hashiqube[0].aws_iam_instance_profile.hashiqube: Creation complete after 2s [id=hashiqube]
module.gcp-hashiqube[0].google_compute_firewall.aws-hashiqube_ip[0]: Still creating... [10s elapsed]
module.gcp-hashiqube[0].google_compute_firewall.whitelist_cidr[0]: Still creating... [10s elapsed]
module.gcp-hashiqube[0].google_compute_firewall.my_ipaddress: Still creating... [10s elapsed]
module.gcp-hashiqube[0].google_project_iam_member.hashiqube: Creation complete after 10s [id=riaan-nolan-xxx/roles/compute.networkViewer/serviceAccount:sa-consul-compute-prod@riaan-nolan-xxx.iam.gserviceaccount.com]
module.gcp-hashiqube[0].google_compute_firewall.my_ipaddress: Creation complete after 13s [id=projects/riaan-nolan-xxx/global/firewalls/hashiqube-my-ipaddress]
module.gcp-hashiqube[0].google_compute_firewall.gcp_hashiqube_ip[0]: Still creating... [10s elapsed]
module.gcp-hashiqube[0].google_compute_firewall.aws-hashiqube_ip[0]: Creation complete after 13s [id=projects/riaan-nolan-xxx/global/firewalls/aws-hashiqube-ip]
module.gcp-hashiqube[0].google_compute_firewall.whitelist_cidr[0]: Creation complete after 13s [id=projects/riaan-nolan-xxx/global/firewalls/whitelist-cidr]
module.gcp-hashiqube[0].google_compute_firewall.gcp_hashiqube_ip[0]: Creation complete after 12s [id=projects/riaan-nolan-xxx/global/firewalls/gcp-hashiqube-ip]
module.azure-hashiqube[0].azurerm_resource_group.hashiqube: Creating...
module.azure-hashiqube[0].azurerm_resource_group.hashiqube: Creation complete after 1s [id=/subscriptions/b6a8efd1-471a-49ed-9835-fa8731a5e9fa/resourceGroups/hashiqube]
module.azure-hashiqube[0].azurerm_virtual_network.hashiqube: Creating...
module.azure-hashiqube[0].azurerm_public_ip.hashiqube: Creating...
module.azure-hashiqube[0].azurerm_public_ip.hashiqube: Creation complete after 2s [id=/subscriptions/b6a8efd1-471a-49ed-9835-fa8731a5e9fa/resourceGroups/hashiqube/providers/Microsoft.Network/publicIPAddresses/hashiqube]
module.aws-hashiqube[0].null_resource.hashiqube: Creating...
module.aws-hashiqube[0].null_resource.hashiqube: Creation complete after 0s [id=3228104445494908378]
module.gcp-hashiqube[0].null_resource.hashiqube: Creating...
module.aws-hashiqube[0].aws_security_group_rule.azure_hashiqube[0]: Creating...
module.gcp-hashiqube[0].google_compute_firewall.azure_hashiqube_ip[0]: Creating...
module.gcp-hashiqube[0].google_compute_instance_template.hashiqube: Creating...
module.gcp-hashiqube[0].null_resource.hashiqube: Creation complete after 0s [id=3220462360550026564]
module.aws-hashiqube[0].aws_instance.hashiqube: Creating...
module.aws-hashiqube[0].aws_security_group_rule.azure_hashiqube[0]: Creation complete after 0s [id=sgrule-2872703526]
module.azure-hashiqube[0].azurerm_virtual_network.hashiqube: Creation complete after 4s [id=/subscriptions/b6a8efd1-471a-49ed-9835-fa8731a5e9fa/resourceGroups/hashiqube/providers/Microsoft.Network/virtualNetworks/hashiqube]
module.azure-hashiqube[0].azurerm_subnet.hashiqube: Creating...
module.azure-hashiqube[0].azurerm_subnet.hashiqube: Creation complete after 4s [id=/subscriptions/b6a8efd1-471a-49ed-9835-fa8731a5e9fa/resourceGroups/hashiqube/providers/Microsoft.Network/virtualNetworks/hashiqube/subnets/hashiqube]
module.azure-hashiqube[0].azurerm_network_interface.hashiqube: Creating...
module.azure-hashiqube[0].azurerm_network_interface.hashiqube: Creation complete after 1s [id=/subscriptions/b6a8efd1-471a-49ed-9835-fa8731a5e9fa/resourceGroups/hashiqube/providers/Microsoft.Network/networkInterfaces/hashiqube]
module.azure-hashiqube[0].azurerm_network_security_group.azure_hashiqube_ip[0]: Creating...
module.azure-hashiqube[0].azurerm_network_security_group.whitelist_cidr[0]: Creating...
module.azure-hashiqube[0].azurerm_network_security_group.aws_hashiqube_ip[0]: Creating...
module.azure-hashiqube[0].azurerm_network_security_group.gcp_hashiqube_ip[0]: Creating...
module.azure-hashiqube[0].azurerm_network_security_group.my_ipaddress: Creating...
module.azure-hashiqube[0].azurerm_linux_virtual_machine.hashiqube: Creating...
module.azure-hashiqube[0].azurerm_network_security_group.whitelist_cidr[0]: Creation complete after 2s [id=/subscriptions/b6a8efd1-471a-49ed-9835-fa8731a5e9fa/resourceGroups/hashiqube/providers/Microsoft.Network/networkSecurityGroups/whitelist_cidr]
module.azure-hashiqube[0].azurerm_network_security_group.azure_hashiqube_ip[0]: Creation complete after 2s [id=/subscriptions/b6a8efd1-471a-49ed-9835-fa8731a5e9fa/resourceGroups/hashiqube/providers/Microsoft.Network/networkSecurityGroups/azure_hashiqube_ip]
module.azure-hashiqube[0].azurerm_network_security_group.gcp_hashiqube_ip[0]: Creation complete after 2s [id=/subscriptions/b6a8efd1-471a-49ed-9835-fa8731a5e9fa/resourceGroups/hashiqube/providers/Microsoft.Network/networkSecurityGroups/gcp_hashiqube_ip]
module.azure-hashiqube[0].azurerm_network_security_group.my_ipaddress: Creation complete after 2s [id=/subscriptions/b6a8efd1-471a-49ed-9835-fa8731a5e9fa/resourceGroups/hashiqube/providers/Microsoft.Network/networkSecurityGroups/hashiqube]
module.azure-hashiqube[0].azurerm_network_security_group.aws_hashiqube_ip[0]: Creation complete after 2s [id=/subscriptions/b6a8efd1-471a-49ed-9835-fa8731a5e9fa/resourceGroups/hashiqube/providers/Microsoft.Network/networkSecurityGroups/aws_hashiqube_ip]
module.gcp-hashiqube[0].google_compute_firewall.azure_hashiqube_ip[0]: Still creating... [10s elapsed]
module.gcp-hashiqube[0].google_compute_instance_template.hashiqube: Still creating... [10s elapsed]
module.aws-hashiqube[0].aws_instance.hashiqube: Still creating... [10s elapsed]
module.gcp-hashiqube[0].google_compute_firewall.azure_hashiqube_ip[0]: Creation complete after 12s [id=projects/riaan-nolan-xxx/global/firewalls/azure-hashiqube-ip]
module.azure-hashiqube[0].azurerm_linux_virtual_machine.hashiqube: Still creating... [10s elapsed]
module.gcp-hashiqube[0].google_compute_instance_template.hashiqube: Creation complete after 17s [id=projects/riaan-nolan-xxx/global/instanceTemplates/hashiqube20230523054916003900000001]
module.gcp-hashiqube[0].google_compute_region_instance_group_manager.hashiqube: Creating...
module.aws-hashiqube[0].aws_instance.hashiqube: Still creating... [20s elapsed]
module.azure-hashiqube[0].azurerm_linux_virtual_machine.hashiqube: Creation complete after 16s [id=/subscriptions/b6a8efd1-471a-49ed-9835-fa8731a5e9fa/resourceGroups/hashiqube/providers/Microsoft.Compute/virtualMachines/hashiqube]
module.gcp-hashiqube[0].google_compute_region_instance_group_manager.hashiqube: Still creating... [10s elapsed]
module.aws-hashiqube[0].aws_instance.hashiqube: Still creating... [30s elapsed]
module.gcp-hashiqube[0].google_compute_region_instance_group_manager.hashiqube: Still creating... [20s elapsed]
module.aws-hashiqube[0].aws_instance.hashiqube: Still creating... [40s elapsed]
module.gcp-hashiqube[0].google_compute_region_instance_group_manager.hashiqube: Still creating... [30s elapsed]
module.aws-hashiqube[0].aws_instance.hashiqube: Still creating... [50s elapsed]
module.gcp-hashiqube[0].google_compute_region_instance_group_manager.hashiqube: Creation complete after 36s [id=projects/riaan-nolan-xxx/regions/australia-southeast1/instanceGroupManagers/hashiqube]
module.aws-hashiqube[0].aws_instance.hashiqube: Still creating... [1m0s elapsed]
module.aws-hashiqube[0].aws_instance.hashiqube: Still creating... [1m10s elapsed]
module.aws-hashiqube[0].aws_instance.hashiqube: Still creating... [1m20s elapsed]
module.aws-hashiqube[0].aws_instance.hashiqube: Still creating... [1m30s elapsed]
module.aws-hashiqube[0].aws_instance.hashiqube: Creation complete after 1m32s [id=i-004984aea1d6f3fff]
module.aws-hashiqube[0].aws_eip_association.eip_assoc: Creating...
module.aws-hashiqube[0].aws_eip_association.eip_assoc: Creation complete after 1s [id=eipassoc-0f10d2ec6d656baf8]
Releasing state lock. This may take a few moments...

Apply complete! Resources: 37 added, 0 changed, 0 destroyed.

Outputs:

aaa_welcome = <<EOT
Your HashiQube instance is busy launching, usually this takes ~5 minutes.
Below are some links to open in your browser, and commands you can copy and paste in a terminal to login via SSH into your HashiQube instance.
Thank you for using this module, you are most welcome to fork this repository to make it your own.
** DO NOT USE THIS IN PRODUCTION **

EOT
aab_instructions = <<EOT
Use the Hashiqube SSH output below to login to your instance
To get Vault Shamir keys and Root token do "sudo cat /etc/vault/init.file"

EOT
aws_hashiqube-boundary = "http://3.105.237.xxx:19200 username: admin password: password"
aws_hashiqube-consul = "http://3.105.237.xxx:8500"
aws_hashiqube-fabio-lb = "http://3.105.237.xxx:9999"
aws_hashiqube-fabio-ui = "http://3.105.237.xxx:9998"
aws_hashiqube-nomad = "http://3.105.237.xxx:4646"
aws_hashiqube-ssh = "ssh ubuntu@3.105.237.xxx"
aws_hashiqube-traefik-lb = "http://3.105.237.xxx:8080"
aws_hashiqube-traefik-ui = "http://3.105.237.xxx:8181"
aws_hashiqube-vault = "http://3.105.237.xxx:8200"
aws_hashiqube-waypoint = "https://3.105.237.xxx:9702"
aws_hashiqube_ip = "3.105.237.xxx"
azure_hashiqube-boundary = "http://20.53.246.xxx:19200 username: admin password: password"
azure_hashiqube-consul = "http://20.53.246.xxx:8500"
azure_hashiqube-fabio-lb = "http://20.53.246.xxx:9999"
azure_hashiqube-fabio-ui = "http://20.53.246.xxx:9998"
azure_hashiqube-nomad = "http://20.53.246.xxx:4646"
azure_hashiqube-ssh = "ssh ubuntu@20.53.246.xxx"
azure_hashiqube-traefik-lb = "http://20.53.246.xxx:8080"
azure_hashiqube-traefik-ui = "http://20.53.246.xxx:8181"
azure_hashiqube-vault = "http://20.53.246.xxx:8200"
azure_hashiqube-waypoint = "https://20.53.246.xxx:9702"
azure_hashiqube_ip = "20.53.246.xxx"
gcp_hashiqube-boundary = "http://34.87.247.xxx:19200 username: admin password: password"
gcp_hashiqube-consul = "http://34.87.247.xxx:8500"
gcp_hashiqube-fabio-lb = "http://34.87.247.xxx:9999"
gcp_hashiqube-fabio-ui = "http://34.87.247.xxx:9998"
gcp_hashiqube-nomad = "http://34.87.247.xxx:4646"
gcp_hashiqube-ssh = "ssh ubuntu@34.87.247.xxx"
gcp_hashiqube-traefik-lb = "http://34.87.247.xxx:8080"
gcp_hashiqube-traefik-ui = "http://34.87.247.xxx:8181"
gcp_hashiqube-vault = "http://34.87.247.xxx:8200"
gcp_hashiqube-waypoint = "https://34.87.247.xxx:9702"
gcp_hashiqube_ip = "34.87.247.xxx"
your_ipaddress = "101.189.211.xxx"
```

## Access the Cloud Instance
Your IP will be whitelisted and you will be able to access the cloud instance with the commands in the Terraform Output, for example: 

```
gcp_hashiqube-ssh = "ssh ubuntu@34.87.247.xxx" so simply do ssh ubuntu@34.87.247.xxx
azure_hashiqube-ssh = "ssh ubuntu@20.53.246.xxx" so simply do ssh ubuntu@20.53.246.xxx
aws_hashiqube-ssh = "ssh ubuntu@3.105.237.xxx" so simply do ssh ubuntu@3.105.237.xxx
```

Your SSH Public key in ~/.ssh/id_rsa.pub will be added to the instances, and you can configure the location of this file via the `variables.tf` file

### Prerequisites

To make use of this module, you need a Cloud account.
AWS, GCP and Azure is supported.

- You need a Public/Private SSH key pair. 
- A Cloud account

__Instructions on how to setup a SSH Key pair__: <br />
[SSH Create a Public/Private Key Pair](https://www.ssh.com/ssh/keygen/) <br /><br />
__Instructions on how to setup Cloud Account__: <br />
[Google Cloud Installation and Setup](https://cloud.google.com/deployment-manager/docs/step-by-step-guide/installation-and-setup)<br />
[AWS Cloud Installation and Setup](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)

When you do Terraform Apply, this is the output you will see. 
![HashiQube SSH](https://github.com/star3am/terraform-hashicorp-hashiqube/blob/master/images/hashiqube-01-terraform-apply.png?raw=true "HashiQube Terraform Apply")

Now that HashiQube is up, let's SSH into the instance. 
![HashiQube SSH](https://github.com/star3am/terraform-hashicorp-hashiqube/blob/master/images/hashiqube-03-ssh.png?raw=true "HashiQube SSH")

You can check the Vault, Consul and Nomad Cluster status.
![HashiQube SSH](https://github.com/star3am/terraform-hashicorp-hashiqube/blob/master/images/hashiqube-02-clusters-status.png?raw=true "HashiQube SSH")

We can access Hashicorp Consul
![Consul](https://github.com/star3am/terraform-hashicorp-hashiqube/blob/master/images/hashiqube-04-consul.png?raw=true "Consul")

We can also access Hashicorp Nomad
![Nomad](https://github.com/star3am/terraform-hashicorp-hashiqube/blob/master/images/hashiqube-05-nomad.png?raw=true "Nomad")

We can now enter Vault's Initial Root Token to login
![HashiQube Logged in](https://github.com/star3am/terraform-hashicorp-hashiqube/blob/master/images/hashiqube-06-vault_initial-logged-in.png?raw=true "HashiQube Logged in")

We can also access Fabio Load Balancer, running as a Nomad job
![Fabio](https://github.com/star3am/terraform-hashicorp-hashiqube/blob/master/images/hashiqube-07-fabio.png?raw=true "Fabio")

#### Inputs

| Name | Type | Default | Description |
|------|-------------|------|---------|
| deploy_to_aws | bool | false | Deploy Hashiqube on AWS |
| deploy_to_gcp | bool | false | Deploy Hashiqube on GCP |
| deploy_to_azure | bool | false | Deploy Hashiqube on Azure |
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
| gcp_zones| list(string) | ["australia-southeast1-a","australia-southeast1-b","australia-southeast1-c"] | The zones accross which GCP resources will be launched |
| gcp_machine_type | string | "n1-standard-1" | GCP machine type | 
| gcp_custom_metadata | map(string) | {} | A map of metadata key value pairs to assign to the Compute Instance metadata |
| gcp_root_volume_disk_size_gb | number | 16 | The size, in GB, of the root disk volume on each HashiQube node |
| gcp_root_volume_disk_type | string | "pd-standard" | The GCE disk type. Can be either pd-ssd, local-ssd, or pd-standard |

#### Outputs

| Name | Description |
|------|-------------|
| ip_address | The IP address of HashiQube instance |
| aws_hashiqube-consul | http://aws_hashiqube-consul:8500
| aws_hashiqube-fabio-lb | http://aws_hashiqube-fabio-lb:9999
| aws_hashiqube-fabio-ui | http://aws_hashiqube-fabio-ui:9998
| aws_hashiqube-nomad | http://aws_hashiqube-nomad:4646
| aws_hashiqube-ssh | ssh ubuntu@54.206.165.xxx
| aws_hashiqube-vault | http://aws_hashiqube-vault:8200
| aws_hashiqube_ip | 54.206.165.xxx
| azure_hashiqube-consul | http://azure_hashiqube-consul:8500
| azure_hashiqube-fabio-lb | http://azure_hashiqube-fabio-lb:9999
| azure_hashiqube-fabio-ui | http://azure_hashiqube-fabio-ui:9998
| azure_hashiqube-nomad | http://azure_hashiqube-nomad:4646
| azure_hashiqube-ssh | ssh ubuntu@13.75.237.xxx
| azure_hashiqube-vault | http://azure_hashiqube-vault:8200
| azure_hashiqube_ip | 13.75.237.xxx
| gcp_hashiqube-consul | http://gcp_hashiqube-consul:8500
| gcp_hashiqube-fabio-lb | http://gcp_hashiqube-fabio-lb:9999
| gcp_hashiqube-fabio-ui | http://gcp_hashiqube-fabio-ui:9998
| gcp_hashiqube-nomad | http://gcp_hashiqube-nomad:4646
| gcp_hashiqube-ssh | ssh ubuntu@34.87.219.xxx
| gcp_hashiqube-vault | http://gcp_hashiqube-vault:8200
| gcp_hashiqube_ip | 34.87.219.xxx
| your_ipaddress | 103.234.250.xxx

### About Me
My name is Riaan Nolan and I was born in South Africa. I started out as a Web Developer in 2000 and from there progressed into Systems Administration, with a strong focus on Automation, Infrastrtucture and Configuration as Code.

I have worked for Multi-National companies in Portugal, Germany, China, South Africa, United States and Australia. 

You are welcome to connect with me on Linkedin https://www.linkedin.com/in/riaannolan/ <br />
Credly profile: https://www.credly.com/users/riaan-nolan.e657145c

![My Hashicorp Badges](images/hashicorp-badges.png?raw=true "My Hashicorp Badges")