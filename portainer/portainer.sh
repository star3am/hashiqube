#!/bin/bash
# https://www.portainer.io/
sudo docker stop portainer
sudo docker rm portainer
yes | sudo docker system prune -a
yes | sudo docker system prune --volumes
sudo docker volume create portainer_data
sudo docker run \
  --name portainer \
  -p 0.0.0.0:8333:8000 \
  -p 0.0.0.0:9333:9000 \
  -v portainer_data:/data \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -d portainer/portainer
echo -e '\e[38;5;198m'"++++ Portainer: http://localhost:9333"
