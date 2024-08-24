# modules - see modules folder for integrations

module "hashicorp-vault" {
  count  = var.vault_enabled ? 1 : 0
  source = "./modules/hashicorp/vault"
}

module "hashicorp-consul" {
  count  = var.consul_enabled ? 1 : 0
  source = "./modules/hashicorp/consul"
}