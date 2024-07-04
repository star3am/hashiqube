/* helpful hints
 * https://github.com/localstack-samples/localstack-terraform-samples
 * https://www.terraform.io/docs/configuration/functions/
 * Localstack Terraform configuration https://docs.localstack.cloud/integrations/terraform/
 * https://github.com/localstack/localstack-pro-samples/tree/master/terraform-resources
 * https://blog.wimwauters.com/devops/2022-03-01_terraformusecases/
*/

locals {
  ec2_instance_with_index = zipmap(
    range(length(var.ec2_instance)),
    var.ec2_instance
  )
  ec2_instance_disk_allocations_basic = [
    for instance in var.ec2_instance : [
      for disk in instance.ebs_disks : {
        az        = instance.az
        ami_id    = instance.ami_id
        subnet_id = instance.subnet_id
        disksize  = disk.disksize
        disktype  = disk.disktype
      }
    ]
  ]
  ec2_instance_disk_allocations_flattened = flatten(local.ec2_instance_disk_allocations_basic)
  ec2_instance_disk_allocations_indexed = zipmap(
    range(length(local.ec2_instance_disk_allocations_flattened)),
    local.ec2_instance_disk_allocations_flattened
  )

  tunnels_with_index = zipmap(
    range(length(var.tunnels)),
    var.tunnels
  )
}

resource "null_resource" "ec2_instance_disk_allocations_indexed" {
  for_each = local.ec2_instance_disk_allocations_indexed
  triggers = {
    availability_zone = each.value.az
    ami_id            = each.value.ami_id
    subnet_id         = each.value.subnet_id
    disksize          = each.value.disksize
    disktype          = each.value.disktype
  }
}

resource "null_resource" "count" {
  count = length(var.ec2_instance)
  triggers = {
    availability_zone = var.ec2_instance[count.index].az
    ami_id            = var.ec2_instance[count.index].ami_id
    subnet_id         = var.ec2_instance[count.index].subnet_id
    instance_type     = var.ec2_instance[count.index].instance_type
    tags              = replace(replace(jsonencode(var.ec2_instance[count.index].tags), "\"", ""), ":", "=")
  }
}

resource "null_resource" "debug" {
  for_each = local.tunnels_with_index
  triggers = {
    host        = each.value.type == "host" ? each.value.host : null
    type        = each.value.type
    address     = each.value.type == "address" ? each.value.address : null
    description = each.value.description
    timestamp   = timestamp()
  }
}

resource "null_resource" "random_pet" {
  triggers = {
    random_pet = random_pet.random.id
  }
}

resource "random_string" "random" {
  length           = 16
  special          = true
  override_special = "/@$"
  min_numeric      = 6
  min_special      = 2
  min_upper        = 3
}

resource "random_pet" "random" {}

resource "aws_s3_bucket" "my-bucket" {
  bucket = "my-bucket"
}

resource "aws_s3_bucket_acl" "my-bucket-acl" {
  bucket = aws_s3_bucket.my-bucket.id
  acl    = "private"
}

resource "aws_security_group" "default-sec-group" {
  name        = "default-sec-group"
  description = "Default Security Group"

  ingress {
    # TLS (change to whatever ports you need)
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    # Please restrict your ingress to only necessary IPs and ports.
    # Opening to 0.0.0.0/0 can lead to security vulnerabilities.
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
