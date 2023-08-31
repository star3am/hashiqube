#!/bin/bash

# https://github.com/louislam/uptime-kuma

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Cleanup"
echo -e '\e[38;5;198m'"++++ "
sudo docker stop uptime-kuma
sudo docker rm uptime-kuma
yes | sudo docker system prune -a
yes | sudo docker system prune --volumes

if pgrep -x "dockerd" >/dev/null
then
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Docker is running"
  echo -e '\e[38;5;198m'"++++ "
else
  echo -e '\e[38;5;198m'"++++ "
  echo -e '\e[38;5;198m'"++++ Ensure Docker is running.."
  echo -e '\e[38;5;198m'"++++ "
  sudo bash /vagrant/docker/docker.sh
fi

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Start Uptime Kuma"
echo -e '\e[38;5;198m'"++++ "
sudo mkdir -p /tmp/uptime-kuma
sudo cp /vagrant/uptime-kuma/kuma.db /tmp/uptime-kuma/
docker run -d --restart=always -p 3001:3001 -v /tmp/uptime-kuma:/app/data --name uptime-kuma louislam/uptime-kuma:1

echo -e '\e[38;5;198m'"++++ Uptime Kuma: http://localhost:3001/ and login with Username: admin and Password: P@ssw0rd"
