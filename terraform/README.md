# Terraform

![Terraform Logo](images/terraform-logo.png?raw=true "Terraform Logo")

In this HashiQube DevOps lab you will get hands on experience with HashiCorp Terraform.

Terraform is an open-source infrastructure as code software tool created by HashiCorp. It enables users to define and provision a datacenter infrastructure using a high-level configuration language known as Hashicorp Configuration Language, or optionally JSON.

## Latest News

- [Terraform 1.6 adds a test framework for enhanced code validation](https://www.hashicorp.com/blog/terraform-1-6-adds-a-test-framework-for-enhanced-code-validation)
- [Terraform 1.5 brings config-driven import and checks](https://www.hashicorp.com/blog/terraform-1-5-brings-config-driven-import-and-checks)
- [Terraform 1.4 improves the CLI experience for Terraform Cloud](https://www.hashicorp.com/blog/terraform-1-4-improves-the-cli-experience-for-terraform-cloud)
- [Terraform 1.3 Improves Extensibility and Maintainability of Terraform Modules](https://www.hashicorp.com/blog/terraform-1-3-improves-extensibility-and-maintainability-of-terraform-modules)
- [Terraform 1.2 Improves Exception Handling and Updates to the CLI-driven Workflow](https://www.hashicorp.com/blog/terraform-1-2-improves-exception-handling-and-updates-to-the-cli-driven-workflow)

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

## Terraform Development Environment

https://medium.com/@riaan.nolan/top-gun-terraform-development-environment-60ac00d49577

As a Hashicorp Certified Terraform Instructor, I get asked a lot of questions from beginners, and I decided to put together a “Best in Class” post with recommendations for Old and New Terraform Developers.

In this post we’ll cover, VSCode’s Dev/Remote containers for a portable (can run on your developers laptops, can run as a build agent, will run on Grannie’s laptop, God bless her soul ❤) all-in-code developer setup.

We’ll cover, TFEnv, TGEnv, TFSec, Terraform Docs, Terraform Format, TFLint, Terraform Validate, Terraform Plan, Pre Commit amongst other

This post is a Buffet, you can pick what you want to eat or try everything, it’s up to you, Bon Appétit!

You can find all the code, ready to use here: https://github.com/star3am/terraform-modules-library

### Terraform Modules Library

This repository forms the basis of my own personal implimentation of a Terraform Modules Library.

It's made up of pre-coded modules to get you started quickly.

It also uses tools, such as TFEnv, Terraform Docs, Linters, VSCode's Dev / Remote containers and many more to provide effectively a Terraform / DevOps engineer development lab to develop and test Terraform Modules.

You are most welcome and in fact encouraged to contribute back to this repository.

![Terraform Modules Library](images/009-owl.png?raw=true "Terraform Modules Library")

### Demo

A quick video walk through demo of this solution

![Terraform Modules Library](images/demo.gif?raw=true "Terraform Modules Library")

### Instructions

- Install VSCode, Docker Desktop and Git
- Clone this repository locally
- Create a new branch to work on
- Open the repository folder in VSCode and remeber to launch in Remote Dev Container
- Create your module folder in the designated cloud module's folder (remember to add an empty terragrunt.hcl file)
- See custom/modules/example for template module
- Start writing your Terraform code, you can use Terraform plan etc. just as you'd normally do
- Periodically run in the VSCode Terminal ./run.sh to check your Terraform Syntax and create your Terraform Documentation for you
- Once you are done, push your code to your branch remote and open a Pull Request on Github
- Ask for reviewers, and make the required changes
- Once you are done, your Module code will be merged to main branch

### Goals

- Provide a delightful developer experience
- Consistent workflows, tools and versions
- Continuously reduce toil and increase automation
- Enable education and encourage learning and development
- Build in security and compliance
- Build internal communities through advocacy
- Employ pragmatic standardization

### Cloud Operating Model

![Unlocking the Cloud Operating Model](images/unlocking-the-cloud-operating-model.png)

### Features

This repository uses some best practice tools to help us with our modules. Tools such as TFENV which automatically installs the correct Terraform Version, Terraform Docs and Terraform Lint, the comprehensive feature list is detailed below.

| Product | State |
|-------|---------|
| VSCode Dev Container | ✓ |
| Pre-Commit | ✓ |
| Terratest | ✘ |
| Terraform | ✓ |
| Terragrunt | ✓ |
| TFEnv | ✓ |
| TGEnv | ✓ |
| TFsec | ✓ |
| AWS | ✓ |
| GCP | ✓ |
| Azure | ✓ |
| Custom | ✓ |
| Terraform Lint | ✓ |
| Terraform Format | ✓ |
| Terraform Validate | ✓ |
| Terraform Docs | ✓ |

- Pre-commit: Runs pre-commit with the given config in `.pre-commit-config.yaml.

- Linters: terraform-lint tflint yamllint

- Terraform lint: terraform fmt -check -recursive -diff

- Terraform format: terraform fmt -check -recursive -diff

- Clean: Clean up .terraform and .terrgrunt-cache folders

- Terraform docs: Create README.md files for each Terraform Module on the fly, generated from your code

- Terraform Plan: Using Terragrunt we run a plan on all modules

### Getting started

Please install the following software

- Docker Desktop https://www.docker.com/products/docker-desktop/
- Visual Studio Code https://code.visualstudio.com/download (with Remote development in Containers extension) https://code.visualstudio.com/docs/remote/containers-tutorial
- Clone this repository
- Now Open VSCode and Open this repository

:bulb: Let's look at some Screenshots of Opening your project

In VSCode, click File -> Open Folder and navigate to this project
![VSCode open repository folder](images/vscode-open-repository-folder.png?raw=true "VSCode open repository folder")

If you have installed the Devcontainer Extension in the previous step, you'd see a Notification, bottom Right.

__Folder contains a Dev Container configuration file. Reopen folder to develop in a container__ and click `Reopen in Container`

![VSCode open repository folder open in devcontainer](images/vscode-open-repository-folder-open-in-devcontainer.png?raw=true "VSCode open repository folder open in devcontainer")

You will see the Docker Build log bottom right and once done, you will see the files of the project in VSCode.

![VSCode open repository folder open in devcontainer docker build
log](images/vscode-open-repository-folder-open-in-devcontainer-build-log.png?raw=true "VSCode open repository folder open in
devcontainer docker build log")

Now you can open a new Terminal. This will launch a new terminal inside the container, you will note that Terraform, Terragrunt and all the tools this project needs has already been installed for you.

![VSCode open repository folder open in devcontainer new Terminal](images/vscode-open-repository-folder-open-in-devcontainer-new-terminal.png?raw=true "VSCode open repository folder open in devcontainer new Terminal")

Now you need to Authenticate to your Clouds, see: __Authenticating__ below.

### Authenticating

Somewhere someone or something has to authenticate against the clouds, the pipeline will take care of this for you, however if you are developing locally, you need to take care of this yourself.

```
export AWS_ACCESS_KEY_ID=
export AWS_SECRET_ACCESS_KEY=
export AWS_REGION=

export GOOGLE_CREDENTIALS=

export ARM_CLIENT_ID=
export ARM_CLIENT_SECRET=
export ARM_SUBSCRIPTION_ID=
export ARM_TENANT_ID=
```

### Example output

When you run ./run.sh you will get the following output

`ubuntu@0c9b71981e0b:/app$ ./run.sh`

```
Similate Pipeline
make lint
--- terraform-lint
>>> Exec (terraform fmt -check -recursive -diff)
--- tflint
--- tflint-module (aws/modules/debug)
>>> Exec (tflint aws/modules/debug)
--- tflint-module (gcp/modules/debug)
>>> Exec (tflint gcp/modules/debug)
--- tflint-module (azure/modules/debug)
>>> Exec (tflint azure/modules/debug)
--- tflint-module (azure/modules/resource-group)
>>> Exec (tflint azure/modules/resource-group)
--- tflint-module (custom/modules/debug)
>>> Exec (tflint custom/modules/debug)
--- yamllint
>>> Exec (yamllint -f auto .)
make tflint
--- tflint
--- tflint-module (aws/modules/debug)
>>> Exec (tflint aws/modules/debug)
--- tflint-module (gcp/modules/debug)
>>> Exec (tflint gcp/modules/debug)
--- tflint-module (azure/modules/debug)
>>> Exec (tflint azure/modules/debug)
--- tflint-module (azure/modules/resource-group)
>>> Exec (tflint azure/modules/resource-group)
--- tflint-module (custom/modules/debug)
>>> Exec (tflint custom/modules/debug)
make format
--- terraform-format
>>> Exec (terraform fmt -recursive -diff)
make clean
--- clean
>>> Exec (find . -type d -name ".terragrunt-cache" -prune -exec rm -rf {} \;)
>>> Exec (find . -type f -name ".terraform.lock.hcl" -prune -exec rm -rf {} \;)
>>> Exec (rm -fr /opt/terragrunt-cache/*)
make docs
--- docs
--- docs-module (aws/modules/debug)
>>> Exec (terraform-docs markdown document --hide requirements --escape=false --sort-by required "aws/modules/debug" > "aws/modules/debug/README.md")
--- docs-module (gcp/modules/debug)
>>> Exec (terraform-docs markdown document --hide requirements --escape=false --sort-by required "gcp/modules/debug" > "gcp/modules/debug/README.md")
--- docs-module (azure/modules/debug)
>>> Exec (terraform-docs markdown document --hide requirements --escape=false --sort-by required "azure/modules/debug" > "azure/modules/debug/README.md")
--- docs-module (azure/modules/resource-group)
>>> Exec (terraform-docs markdown document --hide requirements --escape=false --sort-by required "azure/modules/resource-group" > "azure/modules/resource-group/README.md")
--- docs-module (custom/modules/debug)
>>> Exec (terraform-docs markdown document --hide requirements --escape=false --sort-by required "custom/modules/debug" > "custom/modules/debug/README.md")
make plan-all
--- plan-all ("./")
>>> Exec (terragrunt run-all plan --terragrunt-non-interactive --terragrunt-include-external-dependencies --terragrunt-working-dir "./")
[INFO] Getting version from tgenv-version-name
[INFO] TGENV_VERSION is 0.48.4
INFO[0000] The stack at ./ will be processed in the following order for command plan:
Group 1
- Module /app/aws/modules/debug
- Module /app/azure/modules/debug
- Module /app/azure/modules/resource-group
- Module /app/custom/modules/debug
- Module /app/gcp/modules/debug


Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/null versions matching "~> 3.0"...

Initializing the backend...

Initializing the backend...

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/null versions matching "~> 3.0"...

Initializing provider plugins...
- Finding hashicorp/null versions matching "~> 3.0"...

Initializing provider plugins...
- Finding hashicorp/azurerm versions matching "~> 3.0"...

Initializing the backend...

Initializing provider plugins...
- Finding hashicorp/null versions matching "~> 3.0"...
- Installing hashicorp/null v3.2.1...
- Installing hashicorp/null v3.2.1...
- Installing hashicorp/null v3.2.1...
- Installing hashicorp/azurerm v3.66.0...
- Installing hashicorp/null v3.2.1...
- Installed hashicorp/null v3.2.1 (signed by HashiCorp)

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

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # null_resource.debug will be created
  + resource "null_resource" "debug" {
      + id       = (known after apply)
      + triggers = {
          + "module_folder"            = "/app/custom/modules/debug"
          + "module_name"              = "debug"
          + "module_written_for_cloud" = "custom"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + module_folder            = "/app/custom/modules/debug"
  + module_name              = "debug"
  + module_written_for_cloud = "custom"

─────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
- Installed hashicorp/null v3.2.1 (signed by HashiCorp)

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
- Installed hashicorp/null v3.2.1 (signed by HashiCorp)

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

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # null_resource.debug will be created
  + resource "null_resource" "debug" {
      + id       = (known after apply)
      + triggers = {
          + "module_folder"            = "/app/azure/modules/debug"
          + "module_name"              = "debug"
          + "module_written_for_cloud" = "azure"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + module_folder            = "/app/azure/modules/debug"
  + module_name              = "debug"
  + module_written_for_cloud = "azure"

─────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # null_resource.debug will be created
  + resource "null_resource" "debug" {
      + id       = (known after apply)
      + triggers = {
          + "module_folder"            = "/app/aws/modules/debug"
          + "module_name"              = "debug"
          + "module_written_for_cloud" = "aws"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + module_folder            = "/app/aws/modules/debug"
  + module_name              = "debug"
  + module_written_for_cloud = "aws"

─────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
- Installed hashicorp/null v3.2.1 (signed by HashiCorp)

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

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # null_resource.debug will be created
  + resource "null_resource" "debug" {
      + id       = (known after apply)
      + triggers = {
          + "module_folder"            = "/app/gcp/modules/debug"
          + "module_name"              = "debug"
          + "module_written_for_cloud" = "gcp"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + module_folder            = "/app/gcp/modules/debug"
  + module_name              = "debug"
  + module_written_for_cloud = "gcp"

─────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
- Installed hashicorp/azurerm v3.66.0 (signed by HashiCorp)

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
data.azurerm_subscription.module: Reading...
data.azurerm_subscription.module: Read complete after 0s [id=/subscriptions/b6a8efd1-471a-49ed-9835-fa8731a5e9fa]

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # azurerm_resource_group.module will be created
  + resource "azurerm_resource_group" "module" {
      + id       = (known after apply)
      + location = "australiaeast"
      + name     = "Pay-As-You-Go-rg"
      + tags     = {
          + "Module" = "resource-group"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + id = (known after apply)

─────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
pre-commit run -a
check for added large files..............................................Passed
check for merge conflicts................................................Passed
check vcs permalinks.....................................................Passed
forbid new submodules................................(no files to check)Skipped
don't commit to branch...................................................Passed
fix end of files.........................................................Passed
trim trailing whitespace.................................................Passed
check yaml...............................................................Passed
check for merge conflicts................................................Passed
check for broken symlinks............................(no files to check)Skipped
check json...............................................................Passed
check for case conflicts.................................................Passed
mixed line ending........................................................Passed
detect aws credentials...................................................Passed
detect private key.......................................................Passed
Terraform fmt............................................................Passed
Terraform docs...........................................................Passed
Lint Dockerfiles.........................................................Passed
```

### Contributing

### Adding/Changing a Module

1. Create a new git branch e.g. `feature/xxxxxx`
2. Either `cd` into the module folder and make the changes e.g. `modules/debug/` or create a new module.
3. Run `terraform init` to install providers for the module
4. Run `terraform fmt -check -recursive` to format any changes.
5. If format is successful run `terraform validate`
6. If validate is successful run `terraform plan`

### Testing

1. To test a Terraform module, use a test module (module/xxxxxx/test/)
2. When test module is ready for a Terraform module, run `run.sh` to check the result

### Debugging

At some stage of the game you will need to debug something, this setup, automates away a lot of toil, but with these automation and abstraction comes a lack of visibility.

- Make `make -dn docs` use the -dn flag for make

### FAQs

- Why are You using a Mono Repo?
I try to avoid code duplication and as a small team, to avoid this developers commit hell cycle, I opted for a Mono repo, you are welcome to split it up. You can always use the individual modules using the Terraform Source `source = "git::git@github.com:star3am/terraform-modules-library.git//aws/modules/debug?ref=main"`

### Gotchas

- You will see in the terragrunt.hcl files where I detect the module source I post-fix it with `//.` see this bug: https://github.com/gruntwork-io/terragrunt/issues/1675

- fatal: detected dubious ownership in repository at '/app' To add an exception for this directory see this page: https://www.kenmuse.com/blog/avoiding-dubious-ownership-in-dev-containers/

- I've not found a way to force no-cache so sometimes you need to say ReBuild and ReOpen in Container.

![VSCode ReBuild and ReOpen in Container](images/remote-command-palette.png?raw=true "VSCode ReBuild and ReOpen in Container")

### Thanks!

Many thanks goes to the team at Gruntwork https://gruntwork.io/ for their amazing effort and for selflessly sharing their code in the great spirit of Open Source. In fact https://github.com/gruntwork-io/terragrunt-infrastructure-modules-example inspired this repo and set the foundation for this repo.

### Links

- https://www.terraform.io/
- https://github.com/actions/runner/issues/491#issuecomment-850884422
- https://blog.mergify.com/running-github-actions-only-on-certain-pull-requests/
- https://yonatankra.com/2-ways-to-use-your-docker-image-in-github-actions/
- https://docs.github.com/en/github-ae@latest/actions/learn-github-actions/variables
- https://docs.github.com/en/actions/using-jobs/using-jobs-in-a-workflow
- https://medium.com/@riaan.nolan/top-gun-terraform-development-environment-60ac00d49577
