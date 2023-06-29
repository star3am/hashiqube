output "welcome" {
  value       = <<WELCOME
This is how we can output some Multi-line text.
Welcome to an example Terraform Module
WELCOME
  description = <<WELCOME
This is how we can output some Multi-line text.
Welcome to an example Terraform Module
WELCOME
}

output "terraform_version" {
  value       = var.my_version
  description = "My verion"
}

output "ec2_instance_with_index_zipmap" {
  value = zipmap(range(length(var.ec2_instance)), var.ec2_instance)
}

output "ec2_instance" {
  value = var.ec2_instance
}

output "ec2_instance_disk_allocations_flattened" {
  value = flatten(local.ec2_instance_disk_allocations_basic)
}

output "ec2_instance_disk_allocations_indexed" {
  value = zipmap(range(length(local.ec2_instance_disk_allocations_flattened)), local.ec2_instance_disk_allocations_flattened)
}
