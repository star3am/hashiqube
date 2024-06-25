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

## Further learning 

Thanks to the folks at Localstack for publishing some more examples for us to use and learn Terraform. You can go to this repository on Github, https://github.com/localstack-samples/localstack-terraform-samples/tree/master 

We can then clone it down locally into our `localstack` folder

`git clone git@github.com:localstack-samples/localstack-terraform-samples.git`

Now let's go into this directory, 

`cd localstack-terraform-samples`

There are many examples you can browse, but for now, let's just cd into `demo-deploy`

`cd demo-deploy`

Let's copy our provider.tf to this directory with 

`cp ../../provider.tf .`

Now as always let's do Terraform Init

`terraform init`
```
Initializing the backend...
Initializing modules...
- apigateway in modules/apigateway
- cognito_authorizer in modules/cognito
- dynamo in modules/dynamodb
- lambda_authorizer in modules/lambda
- s3 in modules/s3
- sqs in modules/sqs

Initializing provider plugins...
- Finding latest version of hashicorp/aws...
- Installing hashicorp/aws v5.55.0...
- Installed hashicorp/aws v5.55.0 (signed by HashiCorp)

Terraform has created a lock file .terraform.lock.hcl to record the provider
selections it made above. Include this file in your version control repository
so that Terraform can guarantee to make the same selections by default when
you run "terraform init" in the future.

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Now we can do Terraform Plan

`terraform plan`
```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # module.apigateway[0].aws_api_gateway_integration.apigw-integration-api will be created
  + resource "aws_api_gateway_integration" "apigw-integration-api" {
      + cache_namespace         = (known after apply)
      + connection_type         = "INTERNET"
      + http_method             = "ANY"
      + id                      = (known after apply)
      + integration_http_method = "ANY"
      + passthrough_behavior    = "WHEN_NO_MATCH"
      + request_parameters      = {
          + "integration.request.path.proxy" = "method.request.path.proxy"
        }
      + resource_id             = (known after apply)
      + rest_api_id             = (known after apply)
      + timeout_milliseconds    = 29000
      + type                    = "HTTP_PROXY"
      + uri                     = "https://httpbin.org/anything/{proxy}"
    }

  # module.apigateway[0].aws_api_gateway_integration.apigw-integration-api-proxy will be created
  + resource "aws_api_gateway_integration" "apigw-integration-api-proxy" {
      + cache_namespace         = (known after apply)
      + connection_type         = "INTERNET"
      + http_method             = "ANY"
      + id                      = (known after apply)
      + integration_http_method = "ANY"
      + passthrough_behavior    = "WHEN_NO_MATCH"
      + request_parameters      = {
          + "integration.request.path.proxy" = "method.request.path.proxy"
        }
      + resource_id             = (known after apply)
      + rest_api_id             = (known after apply)
      + timeout_milliseconds    = 29000
      + type                    = "HTTP_PROXY"
      + uri                     = "https://httpbin.org/anything/{proxy}"
    }

  # module.apigateway[0].aws_api_gateway_integration.apigw-integration-proxy will be created
  + resource "aws_api_gateway_integration" "apigw-integration-proxy" {
      + cache_namespace         = (known after apply)
      + connection_type         = "INTERNET"
      + http_method             = "ANY"
      + id                      = (known after apply)
      + integration_http_method = "ANY"
      + passthrough_behavior    = "WHEN_NO_MATCH"
      + request_parameters      = {
          + "integration.request.path.proxy" = "method.request.path.proxy"
        }
      + resource_id             = (known after apply)
      + rest_api_id             = (known after apply)
      + timeout_milliseconds    = 29000
      + type                    = "HTTP_PROXY"
      + uri                     = "https://httpbin.org/anything/{proxy}"
    }

  # module.apigateway[0].aws_api_gateway_method.apigw-method_api will be created
  + resource "aws_api_gateway_method" "apigw-method_api" {
      + api_key_required   = false
      + authorization      = "NONE"
      + http_method        = "ANY"
      + id                 = (known after apply)
      + request_parameters = {
          + "method.request.path.proxy" = true
        }
      + resource_id        = (known after apply)
      + rest_api_id        = (known after apply)
    }

  # module.apigateway[0].aws_api_gateway_method.apigw-method_api_proxy will be created
  + resource "aws_api_gateway_method" "apigw-method_api_proxy" {
      + api_key_required   = false
      + authorization      = "NONE"
      + http_method        = "ANY"
      + id                 = (known after apply)
      + request_parameters = {
          + "method.request.path.proxy" = true
        }
      + resource_id        = (known after apply)
      + rest_api_id        = (known after apply)
    }

  # module.apigateway[0].aws_api_gateway_method.apigw-method_proxy will be created
  + resource "aws_api_gateway_method" "apigw-method_proxy" {
      + api_key_required   = false
      + authorization      = "NONE"
      + http_method        = "ANY"
      + id                 = (known after apply)
      + request_parameters = {
          + "method.request.path.proxy" = true
        }
      + resource_id        = (known after apply)
      + rest_api_id        = (known after apply)
    }

  # module.apigateway[0].aws_api_gateway_resource.apigw-resource_api_proxy will be created
  + resource "aws_api_gateway_resource" "apigw-resource_api_proxy" {
      + id          = (known after apply)
      + parent_id   = (known after apply)
      + path        = (known after apply)
      + path_part   = "{proxy+}"
      + rest_api_id = (known after apply)
    }

  # module.apigateway[0].aws_api_gateway_resource.apigw-resource_proxy will be created
  + resource "aws_api_gateway_resource" "apigw-resource_proxy" {
      + id          = (known after apply)
      + parent_id   = (known after apply)
      + path        = (known after apply)
      + path_part   = "{proxy+}"
      + rest_api_id = (known after apply)
    }

  # module.apigateway[0].aws_api_gateway_resource.apigw_resource_api will be created
  + resource "aws_api_gateway_resource" "apigw_resource_api" {
      + id          = (known after apply)
      + parent_id   = (known after apply)
      + path        = (known after apply)
      + path_part   = "api"
      + rest_api_id = (known after apply)
    }

  # module.apigateway[0].aws_api_gateway_rest_api.apigw will be created
  + resource "aws_api_gateway_rest_api" "apigw" {
      + api_key_source               = (known after apply)
      + arn                          = (known after apply)
      + binary_media_types           = (known after apply)
      + created_date                 = (known after apply)
      + description                  = (known after apply)
      + disable_execute_api_endpoint = (known after apply)
      + execution_arn                = (known after apply)
      + id                           = (known after apply)
      + minimum_compression_size     = (known after apply)
      + name                         = "apigwv1-demo"
      + policy                       = (known after apply)
      + root_resource_id             = (known after apply)
      + tags_all                     = {
          + "Environment" = "Local"
          + "Service"     = "LocalStack"
        }
    }

Plan: 10 to add, 0 to change, 0 to destroy.
```

And finally, we can do Terraform Apply

`terraform apply`
```
Terraform used the selected providers to generate the following execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # module.apigateway[0].aws_api_gateway_integration.apigw-integration-api will be created
  + resource "aws_api_gateway_integration" "apigw-integration-api" {
      + cache_namespace         = (known after apply)
      + connection_type         = "INTERNET"
      + http_method             = "ANY"
      + id                      = (known after apply)
      + integration_http_method = "ANY"
      + passthrough_behavior    = "WHEN_NO_MATCH"
      + request_parameters      = {
          + "integration.request.path.proxy" = "method.request.path.proxy"
        }
      + resource_id             = (known after apply)
      + rest_api_id             = (known after apply)
      + timeout_milliseconds    = 29000
      + type                    = "HTTP_PROXY"
      + uri                     = "https://httpbin.org/anything/{proxy}"
    }

  # module.apigateway[0].aws_api_gateway_integration.apigw-integration-api-proxy will be created
  + resource "aws_api_gateway_integration" "apigw-integration-api-proxy" {
      + cache_namespace         = (known after apply)
      + connection_type         = "INTERNET"
      + http_method             = "ANY"
      + id                      = (known after apply)
      + integration_http_method = "ANY"
      + passthrough_behavior    = "WHEN_NO_MATCH"
      + request_parameters      = {
          + "integration.request.path.proxy" = "method.request.path.proxy"
        }
      + resource_id             = (known after apply)
      + rest_api_id             = (known after apply)
      + timeout_milliseconds    = 29000
      + type                    = "HTTP_PROXY"
      + uri                     = "https://httpbin.org/anything/{proxy}"
    }

  # module.apigateway[0].aws_api_gateway_integration.apigw-integration-proxy will be created
  + resource "aws_api_gateway_integration" "apigw-integration-proxy" {
      + cache_namespace         = (known after apply)
      + connection_type         = "INTERNET"
      + http_method             = "ANY"
      + id                      = (known after apply)
      + integration_http_method = "ANY"
      + passthrough_behavior    = "WHEN_NO_MATCH"
      + request_parameters      = {
          + "integration.request.path.proxy" = "method.request.path.proxy"
        }
      + resource_id             = (known after apply)
      + rest_api_id             = (known after apply)
      + timeout_milliseconds    = 29000
      + type                    = "HTTP_PROXY"
      + uri                     = "https://httpbin.org/anything/{proxy}"
    }

  # module.apigateway[0].aws_api_gateway_method.apigw-method_api will be created
  + resource "aws_api_gateway_method" "apigw-method_api" {
      + api_key_required   = false
      + authorization      = "NONE"
      + http_method        = "ANY"
      + id                 = (known after apply)
      + request_parameters = {
          + "method.request.path.proxy" = true
        }
      + resource_id        = (known after apply)
      + rest_api_id        = (known after apply)
    }

  # module.apigateway[0].aws_api_gateway_method.apigw-method_api_proxy will be created
  + resource "aws_api_gateway_method" "apigw-method_api_proxy" {
      + api_key_required   = false
      + authorization      = "NONE"
      + http_method        = "ANY"
      + id                 = (known after apply)
      + request_parameters = {
          + "method.request.path.proxy" = true
        }
      + resource_id        = (known after apply)
      + rest_api_id        = (known after apply)
    }

  # module.apigateway[0].aws_api_gateway_method.apigw-method_proxy will be created
  + resource "aws_api_gateway_method" "apigw-method_proxy" {
      + api_key_required   = false
      + authorization      = "NONE"
      + http_method        = "ANY"
      + id                 = (known after apply)
      + request_parameters = {
          + "method.request.path.proxy" = true
        }
      + resource_id        = (known after apply)
      + rest_api_id        = (known after apply)
    }

  # module.apigateway[0].aws_api_gateway_resource.apigw-resource_api_proxy will be created
  + resource "aws_api_gateway_resource" "apigw-resource_api_proxy" {
      + id          = (known after apply)
      + parent_id   = (known after apply)
      + path        = (known after apply)
      + path_part   = "{proxy+}"
      + rest_api_id = (known after apply)
    }

  # module.apigateway[0].aws_api_gateway_resource.apigw-resource_proxy will be created
  + resource "aws_api_gateway_resource" "apigw-resource_proxy" {
      + id          = (known after apply)
      + parent_id   = (known after apply)
      + path        = (known after apply)
      + path_part   = "{proxy+}"
      + rest_api_id = (known after apply)
    }

  # module.apigateway[0].aws_api_gateway_resource.apigw_resource_api will be created
  + resource "aws_api_gateway_resource" "apigw_resource_api" {
      + id          = (known after apply)
      + parent_id   = (known after apply)
      + path        = (known after apply)
      + path_part   = "api"
      + rest_api_id = (known after apply)
    }

  # module.apigateway[0].aws_api_gateway_rest_api.apigw will be created
  + resource "aws_api_gateway_rest_api" "apigw" {
      + api_key_source               = (known after apply)
      + arn                          = (known after apply)
      + binary_media_types           = (known after apply)
      + created_date                 = (known after apply)
      + description                  = (known after apply)
      + disable_execute_api_endpoint = (known after apply)
      + execution_arn                = (known after apply)
      + id                           = (known after apply)
      + minimum_compression_size     = (known after apply)
      + name                         = "apigwv1-demo"
      + policy                       = (known after apply)
      + root_resource_id             = (known after apply)
      + tags_all                     = {
          + "Environment" = "Local"
          + "Service"     = "LocalStack"
        }
    }

Plan: 10 to add, 0 to change, 0 to destroy.
```

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')

## Links

- https://localstack.cloud/
- https://github.com/localstack-samples/localstack-terraform-samples
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