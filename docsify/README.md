# Docsify

<div align="center">
  <img src="images/docsify-logo.png" alt="Docsify Logo" width="300px">
  <br><br>
  <p><strong>A magical documentation site generator</strong></p>
</div>

## 🚀 About

In this HashiQube DevOps lab, you'll get hands-on experience with Docsify - a modern documentation site generator.

Docsify generates your documentation website on the fly. Unlike traditional documentation generators, it doesn't produce static HTML files. Instead, it dynamically loads and parses your Markdown files and displays them as a website. Getting started is simple - just create an `index.html` file and you're ready to deploy on platforms like GitHub Pages.

## 📋 Provision

<!-- tabs:start -->

### **Github Codespace**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docsify/docsify.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docsify
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docsify/docsify.sh
```

<!-- tabs:end -->

## 🖥️ Access Your Documentation

After provisioning, you can access Docsify and HashiQube documentation at:

- **URL**: [http://localhost:3333/](http://localhost:3333/)

<div align="center">
  <img src="images/docsify.png" alt="Docsify Interface" width="85%">
  <p><em>Docsify rendering the HashiQube documentation</em></p>
</div>

## ✨ Key Features

- **Zero Static HTML Files** - Generates pages on the fly
- **Simple Configuration** - Minimal setup required to get started
- **Multiple Themes** - Choose from various pre-built themes
- **Plugin System** - Extend functionality with plugins
- **Full-Text Search** - Built-in search capability
- **Compatible with GitHub Pages** - Deploy with ease
- **Markdown Support** - Write documentation in easy-to-use Markdown
- **Flexible API** - Customize to suit your needs

## 🛠️ How It Works

1. Docsify converts your Markdown files into HTML on-demand
2. It uses a single `index.html` as the entry point
3. When users access your documentation site, Docsify:
   - Loads the requested Markdown file
   - Parses it to HTML
   - Renders it in the browser
4. This approach means:
   - No build process required
   - Fast setup and development
   - Easy maintenance and updates

## 📝 Getting Started with Your Own Docs

Want to create your own documentation with Docsify? Here's a simple guide:

1. Create a new directory for your documentation:

   ```bash
   mkdir my-docs && cd my-docs
   ```

2. Initialize Docsify:

   ```bash
   docsify init .
   ```

3. This creates three files:
   - `index.html` - The entry point
   - `README.md` - Your homepage content
   - `.nojekyll` - Prevents GitHub Pages from ignoring files that begin with an underscore

4. Preview your site:

   ```bash
   docsify serve
   ```

5. Start adding more Markdown files and customize your `index.html` as needed!

## 🔧 Provisioner Script

The script below automates the setup of Docsify in your HashiQube environment:

```bash
#!/bin/bash

# Print the commands that are run
set -x

# Stop execution if something fails
set -e

# This script provisions Docsify
if ! [ -x "$(command -v docsify)" ]; then
  echo 'Docsify is not installed, installing it ...' >&2
  curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
  sudo apt-get install -y nodejs && npm i docsify-cli -g && mkdir -p /vagrant/docs && cp -r /vagrant/* /vagrant/docs/ && cd /vagrant && docsify serve docs -p 3333 > /vagrant/docsify.log 2>&1 & echo 'Docsify installed'
else
  echo "Docsify is already installed."
fi
```

## 🔗 Additional Resources

- [Docsify Official Website](https://docsify.js.org/)
- [Docsify GitHub Repository](https://github.com/docsifyjs/docsify/)
- [Docsify Awesome List](https://github.com/docsifyjs/awesome-docsify)
- [Markdown Guide](https://www.markdownguide.org/)
- [GitHub Pages Documentation](https://docs.github.com/en/pages)
