# https://registry.terraform.io/providers/hashicorp/nomad/latest/docs/resources/job

resource "nomad_job" "foo" {
  jobspec = <<EOT
job "foo" {
  datacenters = ["dc1"]
  type        = "service"
  group "foo" {
    task "foo" {
      driver = "raw_exec"
      config {
        command = "/bin/sleep"
        args    = ["1"]
      }

      resources {
        cpu    = 20
        memory = 10
      }

      logs {
        max_files     = 3
        max_file_size = 10
      }
    }
  }
}
EOT
}
