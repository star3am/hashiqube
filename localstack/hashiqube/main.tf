terraform {
  required_version = "~> 1.5"

  required_providers {
    # https://registry.terraform.io/providers/hashicorp/aws/latest
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.67"
    }
    external = {
      source  = "hashicorp/external"
      version = "~> 2.3"
    }
    null = {
      source  = "hashicorp/null"
      version = "~> 3.0"
    }
  }
}

data "external" "myipaddress" {
  program = ["bash", "-c", "curl -m 10 -sk 'https://api.ipify.org?format=json'"]
}

provider "aws" {}

module "hashiqube" {
  source  = "star3am/hashiqube/hashicorp//modules/aws-hashiqube"
  version = "1.1.6"

  deploy_to_aws              = true
  aws_instance_type          = "t2.large"
  use_packer_image           = false
  deploy_to_azure            = false
  deploy_to_gcp              = false
  debug_user_data            = true
  ssh_private_key            = var.ssh_private_key
  ssh_public_key             = var.ssh_public_key
  docker_version             = "5:24.0.8-1~ubuntu.22.04~jammy"
  whitelist_cidrs            = ["${data.external.myipaddress.result.ip}/32"]
  vagrant_provisioners       = "basetools,docker,minikube,ansible-tower"
}
