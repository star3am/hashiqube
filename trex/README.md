# T-Rex

<div align="center">
  <p><strong>The classic Chrome dinosaur runner game - now available in HashiQube</strong></p>
</div>

![Trex Game](images/trex.png?raw=true "Trex Game")

## 🚀 Introduction

The T-Rex Runner Game is an Easter Egg usually hidden on the "No Internet Connection" error page in Google's Chrome web browser. This version allows you to play the game directly in HashiQube, even with an internet connection!

Press the space bar to start the game and to jump over obstacles. In HashiQube, this serves as a fun demo application for presentations.

Enjoy the game and see how far you can make it!

## 🛠️ Provision

Choose one of the following methods to set up your environment:

<!-- tabs:start -->

### **Github Codespace**

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash trex/trex.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docker,docsify,trex
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash trex/trex.sh
```
<!-- tabs:end -->

## 🎮 How to Play

1. After provisioning, access the game through your web browser
2. Press the **space bar** to start the game
3. Use the **space bar** to jump over cacti and other obstacles
4. Use the **down arrow** to duck
5. Try to achieve the highest score possible!

## ⚙️ Provisioning Script

The `trex.sh` script handles the installation and configuration of the T-Rex game:

```bash
[filename](trex.sh ':include :type=code')
```

## 📚 Resources

- [Chrome Dino Game Developer Page](https://chromedino.com/)
- [Original Chrome Source Code](https://cs.chromium.org/chromium/src/components/neterror/resources/offline.js)
- [HashiQube Documentation](https://hashiqube.com)
