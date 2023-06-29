# pre-commit

![Pre-Commit](images/009-owl.png?raw=true "Pre-Commit")

This is an example repository showing how to use Git pre-commit to help you become a better developer.
It does great little things for you such as check your YAML and JSON syntax. But it also helps you stay safe and secure by scanning your repository for AWS credentials and SSH private_key files.

## Install

### Local Development
You will need the following tools to get started before you can use this repo and commence local development

- Docker Desktop
  https://www.docker.com/products/docker-desktop/
- IDE Visual Studio Code (with Remote development in Containers extension)
  https://code.visualstudio.com/docs/remote/containers-tutorial
- Git
  https://git-scm.com/
- Pre-Commit
  https://pre-commit.com/#install

### Build Agent
You will need the following tools installed on the build agent to use this

- Git
- Docker Daemon

You can add your own pre-commit hooks, and there is support for all Operating Systems and most Languages.

Most of all, have fun becoming a better developer <3
=======
## Command Line CLI Supported
| Name | Azure | Google | AWS | Kubectl | Dbt | Terraform | Terragrunt | TFENV | Python | Pip | Packer | Cookiecutter | Pre-Commit |
|------|-------|--------|-----|-------|-------|-----------|------------|-------|--------|-----|--------|--------------|------------|
| Tools | ✓    | ✓      | ✓   | ✓     | ✓     |         ✓ |          ✓ |    ✓  |     ✓  |  ✓  |     ✓  | ✓            |       ✓    |

## Dependencies
- Python
- Git https://git-scm.com/
- IDE (I use Visual Studio Code) https://code.visualstudio.com/
- Docker Desktop https://www.docker.com/products/docker-desktop/
- Pre-Commit https://pre-commit.com/#install
- Terraform https://www.terraform.io/downloads
- Terraform Docs https://github.com/terraform-docs/terraform-docs

## Usage
- pre-commit install

## Links
See:
- https://pre-commit.com/
- https://github.com/antonbabenko/pre-commit-terraform

## Features
- Dockerfile for local development and testing
- Pre-Commit Git hooks https://pre-commit.com/ and https://github.com/antonbabenko/pre-commit-terraform
- Gitlab Pipeline
- Terraform Docs
- Example Terraform Module
- Runs on Multi-OS (Linux, Windows and Mac) and Multi-Arch (amd64 and arm64)

## Local Development
For local development we use Docker and Docker compose. See run.sh

## Operating Architecture Support
| Name | Amd64 | Arch64 |
|------|-------|--------|
| Linux | ✓ | ✓ |
| Linux | ✓ | ✓ |
| Mac | ✓ | ✓ |
| Mac | ✓ | ✓ |
| Windows | ✘ | ✘ |

## Pre-Commit

### A FAIL
```shell
git commit -am "update default tgenv to amd64"

check for added large files..............................................Passed
check for merge conflicts................................................Passed
check vcs permalinks.....................................................Passed
forbid new submodules................................(no files to check)Skipped
don't commit to branch...................................................Failed
- hook id: no-commit-to-branch
- exit code: 1
fix end of files.........................................................Passed
trim trailing whitespace.................................................Passed
check yaml...........................................(no files to check)Skipped
check for merge conflicts................................................Passed
check for broken symlinks............................(no files to check)Skipped
check json...........................................(no files to check)Skipped
check for case conflicts.................................................Passed
mixed line ending........................................................Passed
detect aws credentials...................................................Passed
detect private key.......................................................Passed
Terraform fmt........................................(no files to check)Skipped
Terraform docs.......................................(no files to check)Skipped
Lint Dockerfiles.........................................................Passed
```

### Fix the error
`git checkout -b feature/pre-commit`

### A PASS
```shell
git commit -am "fix pre-commit dont commit to branch"
pre-commit installed at /home/ubuntu/.git-template/hooks/pre-commit
[INFO] Initializing environment for https://github.com/pre-commit/pre-commit-hooks.
[INFO] Initializing environment for https://github.com/antonbabenko/pre-commit-terraform.
[INFO] Initializing environment for https://github.com/hadolint/hadolint.
[INFO] Installing environment for https://github.com/pre-commit/pre-commit-hooks.
[INFO] Once installed this environment will be reused.
[INFO] This may take a few minutes...
check for added large files..............................................Passed
check for merge conflicts................................................Passed
check vcs permalinks.....................................................Passed
forbid new submodules................................(no files to check)Skipped
don't commit to branch...................................................Passed
fix end of files.........................................................Passed
trim trailing whitespace.................................................Passed
check yaml...........................................(no files to check)Skipped
check for merge conflicts................................................Passed
check for broken symlinks............................(no files to check)Skipped
check json...........................................(no files to check)Skipped
check for case conflicts.................................................Passed
mixed line ending........................................................Passed
detect aws credentials...................................................Passed
detect private key.......................................................Passed
Terraform fmt........................................(no files to check)Skipped
Terraform docs.......................................(no files to check)Skipped
Lint Dockerfiles.........................................................Passed
```

## Module Documentation
- See docs folder
