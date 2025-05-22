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
