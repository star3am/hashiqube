# VScode server
https://code.visualstudio.com/

https://github.com/coder/code-server

VSCode is a free, open source IDE. Code-server runs an instance of VS code that can then be accessed locally via browser. This allows us to start up a predictable VScode instance in Vagrant. 

![VSCode](images/vscode.png?raw=true "VSCode")

## Provision

<!-- tabs:start -->
#### **Github Codespaces**

```
bash hashiqube/basetools.sh
bash docker/docker.sh
bash code-server/code-server.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docsify,docker,code-server
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash code-server/code-server.sh
```
<!-- tabs:end -->

## Web UI Access

To access the Web UI visit the following address:
```
http://localhost:7777/
```

The default password will be printed to console on start up. Else it can be obtained by the following command:
```
vagrant ssh -c "< ~/.config/code-server/config.yaml head -n "3" | tail -n +"3""
```

## Future plans

In the future there is potential to add an option for starting different code-server instances. Currently it always launches with the default image. Custom images could be setup that have different things preinstalled (e.g. Image with python, usefull libaries and useful extentions pre installed). 

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')