# Visual Studio Code

<div align="center">
  <img src="images/vscode-logo.png?raw=true" alt="VSCode Microsoft Visual Studio Code">
  <p><strong>A powerful, free code editor with cross-platform compatibility and extensive plugin support</strong></p>
</div>

This page has 2 sections:

* [Visual Studio Code on your laptop](#visual-studio-code-on-your-laptop)
* [Visual Studio Code in your browser](#vscode-in-a-browser)

## 🚀 Introduction

[Visual Studio Code](https://code.visualstudio.com/) (VSCode) is a Code Editor, also referred to as an IDE. It's made by Microsoft, it's completely free, very powerful and runs on all Operating Systems and Architectures. It has many extensions and plugins and can help you write better code faster.

<div align="center">
  <img src="images/vscode.png?raw=true" alt="VSCode">
</div>

## 🛠️ Visual Studio Code on your laptop

### Download and Install

To use VSCode, download it from the official website:
[https://code.visualstudio.com/Download](https://code.visualstudio.com/Download)

### 🧩 Popular VSCode Extensions

Enhance your coding experience with these popular extensions:

* [**Azure Terraform Extension**](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azureterraform) - Azure integration for Terraform
* [**Terraform Extension**](https://marketplace.visualstudio.com/items?itemName=HashiCorp.terraform) - HashiCorp's official Terraform extension
* [**Git History Extension**](https://marketplace.visualstudio.com/items?itemName=donjayamanne.githistory) - View git log, file history, compare branches
* [**GitLens Extension**](https://marketplace.visualstudio.com/items?itemName=eamodio.gitlens) - Supercharge Git capabilities
* [**YAML Extension**](https://marketplace.visualstudio.com/items?itemName=redhat.vscode-yaml) - YAML language support
* [**Docker Remote Extension**](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers) - Dev Containers / Remote Containers support
* [**AWS Toolkit**](https://aws.amazon.com/visualstudiocode/) - AWS integration tools
* [**AWS CloudFormation Extension**](https://marketplace.visualstudio.com/items?itemName=aws-scripting-guy.cform) - CloudFormation support
* [**Dracula Dark Theme**](https://marketplace.visualstudio.com/items?itemName=dracula-theme.theme-dracula) - Popular dark theme
* [**Live Share Extension**](https://marketplace.visualstudio.com/items?itemName=MS-vsliveshare.vsliveshare-pack) - Real-time collaborative development

## 📦 Dev Containers in VSCode

[Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers) in Visual Studio Code let you use a container as a full-featured development environment. This allows you to:

* Open any folder inside (or mounted into) a container
* Take advantage of Visual Studio Code's full feature set
* Use a consistent development environment across your team
* Easily switch between different development environments

A `devcontainer.json` file in your project tells VS Code how to access (or create) a development container with a well-defined tool and runtime stack.

### Hashiqube VSCode Dev Container

Follow these steps to use Hashiqube with VSCode Dev Containers:

1. Start Hashiqube with `vagrant up --provision`

2. Install the [Docker Remote Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

3. In VSCode Top Menu, click on View -> Command Palette and type in:
   `Dev Containers: Attach to Running Container...`

   <div align="center">
     <img src="images/vscode-view-command-palette-attach-to-running-container.png?raw=true" alt="Dev Containers: Attach to Running Container">
   </div>

4. Select the running Hashiqube Container

   <div align="center">
     <img src="images/vscode-view-command-palette-attach-to-running-container-select-hashiqube-container.png?raw=true" alt="Select Hashiqube Container">
   </div>

5. You are now inside Hashiqube Docker container, and you can work locally and interact with Hashiqube

   <div align="center">
     <img src="images/vscode-hashiqube-devcontainer.png?raw=true" alt="VSCode in Dev Container">
   </div>

💡 **Tip**: Remember to do `su - vagrant` and `cd /vagrant` to become the vagrant user so that you work as the vagrant user. You can then issue `kubectl` or `terraform` commands if you ran the provisioners first from a terminal on your laptop.

## 🌐 VSCode in a Browser

Code-server runs an instance of VS code that can be accessed locally via browser. This allows us to start up a predictable VScode instance in Vagrant.

<div align="center">
  <img src="images/vscode-in-a-browser.png?raw=true" alt="VSCode in a Browser">
</div>

### Resources

* [VS Code Official Website](https://code.visualstudio.com/)

* [Code Server GitHub Repository](https://github.com/coder/code-server)

### 🛠️ Provision

In order to provision Visual Studio Code Server (Visual Studio IDE in a browser) you need basetools and docker as dependencies:

```bash
vagrant up --provision-with basetools,docker,vscode-server
```

### Web UI Access

To access the Web UI visit the following address:

```bash
http://localhost:7777/
```

The default password will be printed to console on start up. Alternatively, it can be obtained by the following command:

```bash
vagrant ssh -c "< ~/.config/code-server/config.yaml head -n "3" | tail -n +"3""
```

### 🔮 Future plans

In the future there is potential to add an option for starting different code-server instances. Currently it always launches with the default image. Custom images could be setup that have different things preinstalled (e.g. Image with python, useful libraries and useful extensions pre-installed).

## 📜 The Code

```bash
# The vscode-server.sh script content is included here
```
