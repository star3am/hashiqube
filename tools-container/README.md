# Tools Container

<div align="center">
  <p><strong>A development environment that helps you become a better developer using Git pre-commit hooks</strong></p>
</div>

![Pre-Commit](images/009-owl.png?raw=true "Pre-Commit")

## 🚀 Introduction

This is an example repository showing how to use Git pre-commit to help you become a better developer. The container supports multiple operating systems and architectures (Windows, Linux, Mac - Intel and ARM chipsets).

It performs useful checks such as validating YAML and JSON syntax, while also helping you stay secure by scanning your repository for AWS credentials and SSH private key files.

## 🛠️ Installation

You will need the following tools to get started before you can use this repo and commence local development:

- [Docker Desktop](https://www.docker.com/products/docker-desktop/)
- [Visual Studio Code](https://code.visualstudio.com/docs/remote/containers-tutorial) (with Remote Development in Containers extension)
- [Git](https://git-scm.com/)
- [Pre-Commit](https://pre-commit.com/#install)

### Build Agent Requirements

For CI/CD pipelines, you'll need these tools on your build agent:

- Git
- Docker Daemon
- Docker Compose

## 🔄 CI/CD Integration

### Sample GitLab Build Pipeline

Here's a sample GitLab pipeline that only requires Docker and Docker Compose on the build agent. All commands execute within the Docker container, minimizing your dependency toolchain.

`.gitlab-ci.yml`:

```yaml
[filename](gitlab-ci.yml ':include :type=code yaml')
```

## 🐳 Dockerfile

The Dockerfile installs all necessary tools such as Terraform, kubectl, AWS CLI, Google Cloud CLI, Azure CLI, and more:

```dockerfile
[filename](Dockerfile.txt ':include :type=code docker')
```

## 🧪 Pre-Commit

[Pre-commit](https://pre-commit.com/) is a framework for managing and maintaining multi-language pre-commit hooks.

`.pre-commit.yaml`:

```yaml
[filename](pre-commit-config.yaml ':include :type=code yaml')
```

You can add your own pre-commit hooks, and there is support for all operating systems and most languages.

## 📊 Supported Tools

| Tool | Included |
|------|----------|
| Azure CLI | ✓ |
| Google Cloud CLI | ✓ |
| AWS CLI | ✓ |
| Kubectl | ✓ |
| DBT | ✓ |
| Terraform | ✓ |
| Terragrunt | ✓ |
| TFENV | ✓ |
| Python | ✓ |
| Pip | ✓ |
| Packer | ✓ |
| Cookiecutter | ✓ |
| Pre-Commit | ✓ |

## 💻 Operating System & Architecture Support

| OS | AMD64 | ARM64 |
|----|-------|-------|
| Linux | ✓ | ✓ |
| macOS | ✓ | ✓ |
| Windows | ✘ | ✘ |

## 🔍 Features

- Dockerfile for local development and testing
- Pre-Commit Git hooks ([pre-commit.com](https://pre-commit.com/) and [antonbabenko/pre-commit-terraform](https://github.com/antonbabenko/pre-commit-terraform))
- GitLab Pipeline configuration
- Terraform Docs integration
- Example Terraform Module
- Multi-OS (Linux, macOS) and Multi-Architecture (AMD64 and ARM64) support

## 🚦 Pre-Commit Examples

### Example: Failed Commit

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

### Fixing the Error

Create a feature branch instead of committing to main:

```shell
git checkout -b feature/pre-commit
```

### Example: Successful Commit

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

## 📝 Usage

To activate pre-commit hooks in your repository:

```bash
pre-commit install
```

For local development, use Docker and Docker Compose via the provided `run.sh` script.

## 📚 Resources

- [Pre-Commit Website](https://pre-commit.com/)
- [Pre-Commit Terraform Hooks](https://github.com/antonbabenko/pre-commit-terraform)
- [Module Documentation](/tools-container/docs/#providers)

[filename](tools-container.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')