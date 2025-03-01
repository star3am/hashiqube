# VS Code Server

<div align="center">
  <img src="images/vscode.png" alt="VS Code Server" width="600px">
  <br><br>
  <p><strong>Browser-based Visual Studio Code environment for HashiQube</strong></p>
</div>

## 🚀 About

VS Code Server provides a browser-accessible instance of Visual Studio Code running inside your HashiQube environment. This component combines the power of:

- [Visual Studio Code](https://code.visualstudio.com/) - Microsoft's popular, free, open-source IDE
- [code-server](https://github.com/coder/code-server) - A tool that allows VS Code to run in the browser

By running VS Code Server in your HashiQube environment, you can enjoy a consistent, predictable development environment with all the features of VS Code accessible directly through your web browser.

## 📋 Provision

<!-- tabs:start -->

### **Github Codespace**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash code-server/code-server.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docsify,docker,code-server
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash code-server/code-server.sh
```

<!-- tabs:end -->

## 🔑 Web UI Access

To access the VS Code Server interface:

- **URL**: [http://localhost:7777/](http://localhost:7777/)
- **Password**: The default password is printed to the console during startup.

If you need to retrieve the password later, you can use:

```bash
vagrant ssh -c "< ~/.config/code-server/config.yaml head -n "3" | tail -n +"3""
```

## 🔍 Key Features

- **Browser-Based Development** - Access a full VS Code environment through your browser
- **Integrated Terminal** - Run commands directly in your HashiQube environment
- **Extension Support** - Install and use VS Code extensions
- **Consistent Environment** - Work with a predictable development environment across different machines
- **File Access** - Browse and edit files in your HashiQube environment
- **Git Integration** - Work with Git repositories directly from the IDE

## 💻 Usage Tips

1. **Extensions**: Install VS Code extensions directly from the Extensions view (Ctrl+Shift+X)
2. **Terminal**: Open a new terminal from the menu or with Ctrl+`
3. **File Explorer**: Navigate your HashiQube environment with the built-in file explorer
4. **Settings Sync**: Your settings are persisted within your HashiQube environment
5. **Debugging**: Use VS Code's powerful debugging capabilities directly in the browser

## 🔮 Future Plans

In future versions, we plan to offer multiple code-server instances with different configurations:

- Specialized environments for different programming languages
- Pre-installed extensions for specific use cases
- Custom images with pre-installed libraries and tools
- Themed environments for different types of development work

These specialized instances will allow you to quickly spin up purpose-built development environments tailored to specific tasks or technologies.

## 📚 Additional Resources

- [VS Code Documentation](https://code.visualstudio.com/docs)
- [code-server GitHub Repository](https://github.com/coder/code-server)
- [VS Code Extensions Marketplace](https://marketplace.visualstudio.com/vscode)
