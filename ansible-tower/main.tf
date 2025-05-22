variable "tower_cli_remote" {
  type    = string
  default = "~/.local/bin/awx"
}

variable "tower_cli_local" {
  type    = string
  default = "/home/vagrant/.local/bin/awx"
}

variable "tower_host" {
  type    = string
  default = "http://localhost:8043/"
}

variable "tower_password" {
  type      = string
  sensitive = true
  default   = "password"
}

data "external" "tower_token" {
  program = ["/bin/bash", "-c", "${var.tower_cli_local} login --conf.host ${var.tower_host} --conf.insecure --conf.username admin --conf.password \"${var.tower_password}\""]
}

locals {
  timestamp = timestamp()
}

resource "null_resource" "awx_cli" {
  triggers = {
    timestamp = local.timestamp
  }

  provisioner "remote-exec" {
    inline = [
      "${var.tower_cli_remote} --conf.host ${var.tower_host} -f human job_templates launch ansible-role-example-role --monitor --filter status --conf.insecure --conf.token ${data.external.tower_token.result.token}",
    ]
    on_failure = continue
    connection {
      type        = "ssh"
      user        = "vagrant"
      password    = "vagrant"
      host        = "localhost"
    }
  }

  provisioner "local-exec" {
    command    = "${var.tower_cli_local} --conf.host ${var.tower_host} -f human job_templates launch ansible-role-example-role --monitor --filter status --conf.insecure --conf.token ${data.external.tower_token.result.token}"
    on_failure = continue
  }
}
