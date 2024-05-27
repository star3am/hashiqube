job "exec" {
  datacenters = ["dc1"]
  type = "system"

  update {
    stagger = "10s"
    max_parallel = 1
  }

  group "exec" {
    task "exec" {
      driver = "exec"

      config {
        command = "/usr/bin/date"
      }
      resources {}
    }
  }
}
