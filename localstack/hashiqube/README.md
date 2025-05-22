# Deploy HashiQube on AWS, GCP, Azure or All of them

You simple need to configure your Cloud authentication, and this is done by exporting the following Environment variables, be sure to look at the helpful links

## Authentication

- Azure: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal
- AWS: https://registry.terraform.io/providers/hashicorp/aws/latest/docs#environment-variables
- GCP: https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference.html#authentication-configuration

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal<br />
export AWS_ACCESS_KEY_ID=YOUR_AWS_ACCESS_KEY_ID<br />
export AWS_SECRET_ACCESS_KEY=YOUR_AWS_SECRET_ACCESS_KEY<br />
export AWS_REGION=YOUR_AWS_REGION<br />

https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/provider_reference.html#authentication-configuration<br />
export GOOGLE_CREDENTIALS='YOUR_GOOGLE_CREDENTIALS_FILE_JSON'<br />

https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/guides/service_principal_client_secret#creating-a-service-principal<br />
export ARM_CLIENT_ID=YOUR_ARM_CLIENT_ID<br />
export ARM_CLIENT_SECRET=YOUR_ARM_CLIENT_SECRET<br />
export ARM_SUBSCRIPTION_ID=YOUR_ARM_SUBSCRIPTION_ID<br />
export ARM_TENANT_ID=YOUR_ARM_TENANT_ID<br />

## Terraform Auto TFVars

Rename localstack/hashiqube/terraform.auto.tfvars.example to localstack/hashiqube/terraform.auto.tfvars

Add your SSH Public Key and Private key in localstack/hashiqube/terraform.auto.tfvars

You should already have Terraform installed, if you don't see this link: https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

## Run Terraform

Now you can run:

- `terraform init`
- `terraform plan`
- `terraform apply`

You will see HashiQube launching and it will stream the User Data debug output,

## IMPORTANT

Don't forget to clean up and run `terraform destroy` after you are done to avoid Cloud costs!

For further reading see:

- https://hashiqube.com
- https://registry.terraform.io/modules/star3am/hashiqube/hashicorp/latest
