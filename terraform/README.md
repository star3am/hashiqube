# Terraform

https://www.terraform.io/

![Terraform Logo](images/terraform-logo.png?raw=true "Terraform Logo")

Terraform is an open-source infrastructure as code software tool created by HashiCorp. It enables users to define and provision a datacenter infrastructure using a high-level configuration language known as Hashicorp Configuration Language, or optionally JSON.

### Why Terraform
- Provides a high-level abstraction of infrastructure (IaC)
- Allows for composition and combination
- Supports parallel management of resources (graph, fast)
- Separates planning from execution (dry-run)

Because of this flexibility, Terraform can be used to solve many different problems.

### Introduction to Terraform

HashiCorp Co-Founder and CTO, Armon Dadgar, explains the basics of Terraform, what it is, and how it works in this informative whiteboard video. 

[![Armon Dadgar: Introduction to Terraform](images/maxresdefault.jpeg)](https://www.youtube.com/watch?v=h970ZBgKINg)

### Terraform lifecycle
The Terraform lifecycle consists of the following four phases

```bash
terraform init -> terraform plan -> terraform apply -> terraform destroy
```

### Terraform Best Practices

What is the optimal workflow process for Terraform in a large, multi-team enterprise? Watch this whiteboard video by Terraform co-creator Armon Dadgar to find out about the high-scale Terraform best practices. Speaker: Armon Dadgar, Co-Founder & CTO, HashiCorp

[![Armon Dadgar: Terraform Workflow at Scale, Best Practices](images/maxresdefault-terraform-best-practices.jpeg)](https://www.youtube.com/watch?v=9c0s93GcXVw)

### Terraform Language
HashiCorp Configuration Language (HCL)
- Variables
- Outputs
- Resources
- Providers

Providers extend the language functionality
- Infrastructure as Code (IaC)

### Terraform Modules and Providers
Modules build and extend on the resources defined by providers.

|Modules | Providers|
|--------|----------|
|Container of multiple resources used together | Defines resource types that Terraform manages|
|Sourced through a registry or local files | Configure a specific infrastructue platform|
|Consists of .tf and/or .tf.json files | Contains instructions for API interactions|
|Re-usable Terraform configuration | Written in Go Lanaguage|
|Built on top of providers | Foundation for modules|

`terraform plan`

```log
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.

null_resource.ec2_instance_disk_allocations_indexed["3"]: Refreshing state... [id=8937245650602921629]
null_resource.ec2_instance_disk_allocations_indexed["5"]: Refreshing state... [id=7730763927227710655]
null_resource.ec2_instance_disk_allocations_indexed["1"]: Refreshing state... [id=2667993646128215089]
null_resource.ec2_instance_disk_allocations_indexed["2"]: Refreshing state... [id=2799175647628082337]
null_resource.ec2_instance_disk_allocations_indexed["4"]: Refreshing state... [id=3516596870015825764]
null_resource.ec2_instance_disk_allocations_indexed["0"]: Refreshing state... [id=2638599405833480007]
aws_s3_bucket.localstack-s3-bucket: Refreshing state... [id=localstack-s3-bucket]

------------------------------------------------------------------------

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # aws_s3_bucket.localstack-s3-bucket will be created
  + resource "aws_s3_bucket" "localstack-s3-bucket" {
      + acceleration_status         = (known after apply)
      + acl                         = "public-read"
      + arn                         = (known after apply)
      + bucket                      = "localstack-s3-bucket"
      + bucket_domain_name          = (known after apply)
      + bucket_regional_domain_name = (known after apply)
      + force_destroy               = false
      + hosted_zone_id              = (known after apply)
      + id                          = (known after apply)
      + region                      = (known after apply)
      + request_payer               = (known after apply)
      + website_domain              = (known after apply)
      + website_endpoint            = (known after apply)

      + versioning {
          + enabled    = (known after apply)
          + mfa_delete = (known after apply)
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

------------------------------------------------------------------------

Note: You didn't specify an "-out" parameter to save this plan, so Terraform
can't guarantee that exactly these actions will be performed if
"terraform apply" is subsequently run.
```

## Terraform Vagrant Provisioner

`terraform.sh`

[filename](terraform.sh ':include :type=code')

## Terraform Cloud
https://app.terraform.io/ <br>
https://www.hashicorp.com/resources/what-is-terraform-cloud <br>
__Authentication__<br>
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal <br>
https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables <br>
https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference.html#authentication-configuration

Terraform Cloud is a SaaS that we support—that instead, when you run Terraform you still could run it on your local machine, but now it saves and retrieves the state file from Terraform Cloud—which is running over here.

This simplifies a lot of things. First of all, this is pretty much invisible. It still exists, but we manage it for you. Second of all, we could perform a lot more security on this access. You can see who is accessing your state file, control who accesses the state file, and more.

In addition to that, Terraform Cloud will also version and back up your state file so that you could go back in time and see what your infrastructure looked like in the past—or if something went wrong, you could restore a past version. This is something that's really tricky with a local file because this is a normal file on your computer—you would have to be responsible for this yourself. In Terraform Cloud's case, you could still talk directly to the various cloud providers. That's how Terraform Cloud works today. That's the major benefit that remote state brings for you.

HashiCorp co-founder and CTO Mitchell Hashimoto gives a short whiteboard illustration of Terraform Cloud—a new service from HashiCorp that removes the hassle of managing Terraform state files across multiple teams, while also providing a centralized change history and policy governance.

[![Introduction to Terraform Cloud](images/maxresdefault-terraform-cloud.jpeg)](https://www.youtube.com/watch?v=ihAKcn9SE_M)

## Terraform Cloud collaboration/governance

On top of remote state, there are a number of other features in Terraform Cloud in other tiers that enable things like centralized runs, plan approvals, and more. This changes this behavior, so that instead of talking directly to the cloud providers it talks instead to Terraform Cloud.

Here, instead of talking directly to the cloud providers, what would happen is all your requests to plan and apply would go through Terraform Cloud. Then from here—would then go to the cloud providers. As I said, this is optional. You could use the state storage and talk directly to the cloud providers or you could add this on and use this in the middle.

The benefit is you have a full history here of all the runs that have ever happened. Terraform ensures that only one run happens at a time—and you can get approvals. So, if Alice submits a plan to change infrastructure, Bob has to approve it before it goes through.

You can see how having a SaaS around Terraform can simplify and hide a lot of internal details that are difficult to do with Terraform alone. Broadly, the theme around this is collaboration.

Terraform on your computer—by itself—is a great, powerful tool. But it makes it really hard as soon as you're working with a team or with many people. You can do it. There are ways to coordinate this, but we're introducing Terraform Cloud to make this easy and automatic, and idiomatic in terms of how it should work across all Terraform users.

This makes it clean to have access control here, access control here, history—and you still keep the same Terraform workflow. It's still terraform plan, terraform apply, just like you would here. It will automatically use Terraform Cloud in the backend.

## Hashiqube Multi-Cloud

I use Terraform Cloud to build and test the Terraform changes for Hashiqube's Multi-Cloud Terraform Registry Module

You can read more about Hashiqube Multi-Cloud here:
[__Hashiqube Multi Cloud__](/multi-cloud/#terraform-hashicorp-hashiqube)

https://registry.terraform.io/modules/star3am/hashiqube/hashicorp/latest

## Hashiqube Variables

| Key | Value | Category |
|-----|-------|----------|
| aws_region | ap-southeast-2 |	terraform |
| deploy_to_aws | true | terraform |
| deploy_to_azure | true | terraform |
| deploy_to_gcp | true | terraform |
| gcp_project | SENSITIVE |	terraform |
| gcp_region | australia-southeast1 | terraform	|
| ssh_public_key | SENSITIVE | terraform |
| ARM_CLIENT_ID | SENSITIVE | env |
| ARM_CLIENT_SECRET | SENSITIVE	| env |
| ARM_SUBSCRIPTION_ID | SENSITIVE | env	|
| ARM_TENANT_ID | SENSITIVE	| env |
| AWS_ACCESS_KEY_ID | SENSITIVE	| env |
| AWS_SECRET_ACCESS_KEY | SENSITIVE	| env |
| AWS_REGION | ap-southeast-2 | env |
| GOOGLE_CREDENTIALS | SENSITIVE | env |

:bulb: Google credentials was generated by passing the Google Authentication JSON file to this command 

`cat ~/.gcp/credentials.json | jq -c`

### Terraform Cloud run
![Hashiqube Multi-Cloud](images/hashiqube-multi-cloud-terraform-cloud-plan.png?raw=true "Hashiqube Multi-Cloud")

## Terraform Enterprise
https://www.terraform.io/docs/enterprise/index.html

Terraform Enterprise is our self-hosted distribution of Terraform Cloud. It offers enterprises a private instance of the Terraform Cloud application, with no resource limits and with additional enterprise-grade architectural features like audit logging and SAML single sign-on.

Terraform Cloud is an application that helps teams use Terraform together. It manages Terraform runs in a consistent and reliable environment, and includes easy access to shared state and secret data, access controls for approving changes to infrastructure, a private registry for sharing Terraform modules, detailed policy controls for governing the contents of Terraform configurations, and more.

For independent teams and small to medium-sized businesses, Terraform Cloud is also available as a hosted service at https://app.terraform.io.

__Make sure you get a Terraform Licence file and place it in hashicorp directory e.g hashicorp/ptfe-license.rli__

When you run `vagrant up --provision-with terraform-enterprise` system logs and docker logs will be followed, the output will be in read, don't worry. This is for status output, __the installation takes a while__. The output will end when Terraform Enterprise is ready.

Once done, you will see __++++ To finish the installation go to http://10.9.99.10:8800__

![Terraform Enterprise](images/terraform-enterprise.png?raw=true "Terraform Enterprise")
![Terraform Enterprise](images/terraform-enterprise_logged_in.png?raw=true "Terraform Enterprise")

`vagrant up --provision-with terraform-enterprise`

```log
Bringing machine 'user.local.dev' up with 'virtualbox' provider...
==> user.local.dev: Checking if box 'ubuntu/xenial64' version '20190918.0.0' is up to date...
==> user.local.dev: [vagrant-hostsupdater] Checking for host entries
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 consul-user.local.dev
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 vault-user.local.dev
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 nomad-user.local.dev
==> user.local.dev: Running provisioner: terraform-enterprise (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20191118-33309-16vz6hz.sh
    ...
    user.local.dev: Installing replicated-operator service
    user.local.dev: Starting replicated-operator service
    user.local.dev:
    user.local.dev: Operator installation successful
    user.local.dev: To continue the installation, visit the following URL in your browser:
    user.local.dev:
    user.local.dev:   http://10.9.99.10:8800
```
