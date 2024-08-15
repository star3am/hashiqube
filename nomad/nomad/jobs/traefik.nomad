# https://traefik.io/blog/traefik-proxy-fully-integrates-with-hashicorp-nomad/

job "traefik" {
  datacenters = ["dc1"]
  type        = "service"

  group "traefik" {
    count = 1

    network {
      port  "http"{
         static = 8080
      }
      port  "admin"{
         static = 8081
      }
    }

    service {
      name = "traefik-http"
      provider = "nomad"
      port = "http"
    }

    task "server" {
      driver = "docker"
      config {
        image = "traefik:latest"
        ports = ["admin", "http"]
        args = [
          "--api.dashboard=true",
          "--api.insecure=true", ### For Test only, please do not use that in production
          "--entrypoints.web.address=0.0.0.0:${NOMAD_PORT_http}",
          "--entrypoints.traefik.address=0.0.0.0:${NOMAD_PORT_admin}",
          "--providers.nomad=true",
          "--providers.nomad.endpoint.address=http://${attr.unique.network.ip-address}:4646" ### IP to your nomad server
        ]
      }
    }
  }
}
