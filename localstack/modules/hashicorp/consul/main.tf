# https://registry.terraform.io/providers/hashicorp/consul/latest/docs/resources/service

resource "consul_service" "vault" {
  name = "vault"
  node = "hashiqube0"
  port = 8200

  check {
    check_id                          = "service:vault"
    name                              = "Vault health check"
    status                            = "passing"
    http                              = "http://127.0.0.1:8200"
    tls_skip_verify                   = true
    method                            = "GET"
    interval                          = "5s"
    timeout                           = "1s"
    deregister_critical_service_after = "30s"
  }
}
