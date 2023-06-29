## Providers

The following providers are used by this module:

- <a name="provider_external"></a> [external](#provider_external) (2.2.3)

- <a name="provider_null"></a> [null](#provider_null) (3.2.1)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [null_resource.debug](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) (resource)
- [null_resource.ec2_instance_disk_allocations_indexed](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) (resource)
- [external_external.my_ipaddress](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) (data source)

## Required Inputs

No required inputs.

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_aws_region"></a> [aws_region](#input_aws_region)

Description: n/a

Type: `string`

Default: `"ap-southeast-2"`

### <a name="input_ec2_instance"></a> [ec2_instance](#input_ec2_instance)

Description: n/a

Type:

```hcl
list(
    object({
      ami_id         = string
      instance_type  = string
      az             = string
      set_public_ip  = bool
      subnet_id      = string
      security_group = list(string)
      tags           = map(string)
      ebs_disks = list(
        object({
          disksize   = number
          encryption = bool
          disktype   = string
          devicename = string
      }))
    })
  )
```

Default:

```json
[
  {
    "ami_id": "ami-02e8cbf7681c3ae51",
    "az": "ap-southeast-2",
    "ebs_disks": [
      {
        "devicename": "/dev/sdg",
        "disksize": 128,
        "disktype": "gp3",
        "encryption": true
      },
      {
        "devicename": "/dev/sdf",
        "disksize": 64,
        "disktype": "gp2",
        "encryption": false
      }
    ],
    "instance_type": "t1.micro",
    "security_group": [
      "dev-eksblueprint-sbx-node"
    ],
    "set_public_ip": false,
    "subnet_id": "subnet-07e73ebcae662e4a3",
    "tags": {
      "Environment": "dev",
      "Name": "dev-eksblueprint-sbx-node"
    }
  },
  {
    "ami_id": "ami-02e8cbf7681c3ae51",
    "az": "ap-southeast-2",
    "ebs_disks": [
      {
        "devicename": "/dev/sdf",
        "disksize": 128,
        "disktype": "gp3",
        "encryption": true
      },
      {
        "devicename": "/dev/sdg",
        "disksize": 64,
        "disktype": "gp2",
        "encryption": false
      }
    ],
    "instance_type": "t2.micro",
    "security_group": [
      "dev-eksblueprint-sbx-node"
    ],
    "set_public_ip": false,
    "subnet_id": "subnet-07e73ebcae662e4a3",
    "tags": {
      "Environment": "dev",
      "Name": "dev-eksblueprint-sbx-node"
    }
  },
  {
    "ami_id": "ami-02e8cbf7681c3ae51",
    "az": "ap-southeast-2",
    "ebs_disks": [
      {
        "devicename": "/dev/sdf",
        "disksize": 128,
        "disktype": "gp3",
        "encryption": true
      },
      {
        "devicename": "/dev/sdg",
        "disksize": 64,
        "disktype": "gp2",
        "encryption": false
      }
    ],
    "instance_type": "t3.micro",
    "security_group": [
      "dev-eksblueprint-sbx-node"
    ],
    "set_public_ip": false,
    "subnet_id": "subnet-07e73ebcae662e4a3",
    "tags": {
      "Environment": "dev",
      "Name": "dev-eksblueprint-sbx-node"
    }
  }
]
```

### <a name="input_my_version"></a> [my_version](#input_my_version)

Description: n/a

Type: `string`

Default: `"1.0.0"`

## Outputs

The following outputs are exported:

### <a name="output_ec2_instance"></a> [ec2_instance](#output_ec2_instance)

Description: n/a

### <a name="output_ec2_instance_disk_allocations_flattened"></a> [ec2_instance_disk_allocations_flattened](#output_ec2_instance_disk_allocations_flattened)

Description: n/a

### <a name="output_ec2_instance_disk_allocations_indexed"></a> [ec2_instance_disk_allocations_indexed](#output_ec2_instance_disk_allocations_indexed)

Description: n/a

### <a name="output_ec2_instance_with_index_zipmap"></a> [ec2_instance_with_index_zipmap](#output_ec2_instance_with_index_zipmap)

Description: n/a

### <a name="output_terraform_version"></a> [terraform_version](#output_terraform_version)

Description: My verion

### <a name="output_welcome"></a> [welcome](#output_welcome)

Description: This is how we can output some Multi-line text.  
Welcome to an example Terraform Module
