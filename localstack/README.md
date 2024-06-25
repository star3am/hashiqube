# Localstack

![Localstack Logo](images/localstack-logo.png?raw=true "Localstack Logo")

In this HashiQube DevOps lab you will get hands on experience with Localstack and Terraform.

LocalStack provides an easy-to-use test/mocking framework for developing Cloud applications. It spins up a testing environment on your local machine that provides the same functionality and APIs as the real AWS cloud environment.

## Localstack

To get Localstack installed and running in Hashiqube, you can use the following command

`vagrant up --provision-with basetools,localstack`

## Localstack Web Interface

After you ran this provisioner above you will see that it also ran some Terraform for you, we will shortly access Hashiqube and run Terraform again, but before we do, let's create a login at https://www.localstack.cloud/

So head over to https://www.localstack.cloud/ and Register yourself a user or click here https://app.localstack.cloud/sign-up

I Registered with SSO using my github Credentials. 

Once you have logged in you will see the Localstack Dashboard like below.

![Localstack Dashboard](images/localstack-dashboard.png?raw=true "Localstack Dashboard")

## Localstack Instances 

If you scroll down a bit, you will see in the left hand menu, your running instances. 

![Localstack Instances](images/localstack-dashboard.png?raw=true "Localstack Instances")

If you click on S3 you will see that we have just created a bucket with our Terraform Code. 

![Localstack S3](images/localstack-instances-click-on-s3.png?raw=true "Localstack S3")

![Localstack S3](images/localstack-instances-my-bucket.png?raw=true "Localstack S3")

## Run Terraform

Go ahead and Install Terraform on your Laptop

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli 

Let's make sure Terraform is installed by typing in our terminal `terraform -version` You should see output similar to mine below.

`terraform -version`
```
Terraform v1.5.7
on darwin_arm64
+ provider registry.terraform.io/hashicorp/aws v5.55.0
+ provider registry.terraform.io/hashicorp/null v3.2.2
+ provider registry.terraform.io/hashicorp/random v3.6.2

Your version of Terraform is out of date! The latest version
is 1.8.5. You can update by downloading from https://www.terraform.io/downloads.html
```

Now let's make sure we are in the localstack directory, by doing `cd localstack`

After I did that, I can check with the command `pwd`

`pwd`
```
/Users/riaan/workspace/personal/hashiqube/localstack
```

### terraform init

Now we can run `terraform init` 

```log
Initializing the backend...
Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "aws" (hashicorp/aws) 2.33.0...
The following providers do not have any version constraints in configuration,
so the latest version was installed.
To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.
* provider.aws: version = "~> 2.33"
Terraform has been successfully initialized!
You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.
If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

### terraform plan

Now we can run `terraform plan` 

```log
Refreshing Terraform state in-memory prior to plan...
The refreshed state will be used to calculate this plan, but will not be
persisted to local or remote state storage.
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

### terraform apply

Now we can run `terraform apply` 

```log
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
Do you want to perform these actions?
 Terraform will perform the actions described above.
 Only 'yes' will be accepted to approve.
 Enter a value: yes
aws_s3_bucket.localstack-s3-bucket: Creating...
aws_s3_bucket.localstack-s3-bucket: Creation complete after 0s [id=localstack-s3-bucket]
Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

Now check the assets with aws local inside vagrant

`vagrant ssh -c "awslocal s3 ls"`
```
2024-06-25 17:42:18 my-bucket
```

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')

## Links

- https://localstack.cloud/
- https://github.com/localstack/localstack-pro-samples/blob/master/terraform-resources/test.tf
- https://www.terraform.io/docs/providers/aws/guides/custom-service-endpoints.html
- https://www.terraform.io
- https://localstack.cloud
- https://github.com/localstack/localstack
= https://github.com/localstack/awscli-local

## Localstack Terraform Examples

[filename](variables.tf ':include :type=code hcl')

[filename](main.tf ':include :type=code hcl')

[filename](outputs.tf ':include :type=code hcl')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')