# Trex

Dinosaur T-Rex Game

This Easter Egg is usually hidden on the No Internet connection error page in Google's Chrome web browser and played offline. Here, however, you can play the hacked Dino T-Rex Runner Game on Hashiqube. 

Press the space bar to start the game and also to jump over the obstacles.

In Hashiqube, I use it as a demo application when I do presentations.

Enjoy! 

![Trex Game](images/trex.png?raw=true "Trex Game")

## Provision

<!-- tabs:start -->
#### **Github Codespaces**
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)
```
bash docker/docker.sh
bash trex/trex.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docker,docsify,trex
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash trex/trex.sh
```
<!-- tabs:end -->

## Provisioner

[filename](trex.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')