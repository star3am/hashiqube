project = "hashiqube"

app "hashiqube" {
  labels = {
    "service" = "hashiqube",
    "env"     = "dev"
  }

  build {
    use "docker" {
      dockerfile = "./Dockerfile-Hashiqube-com"
      no_cache   = true
    }
    registry {
      use "aws-ecr" {
        region     = "ap-southeast-2"
        repository = "hashiqube"
        tag        = "latest"
      }
    }
  }

  deploy {
    use "aws-ecs" {
      region = "ap-southeast-2"
      memory = "512"
      # https://github.com/hashicorp/waypoint/pull/3068
      architecture = "arm64"
    }
  }

}
