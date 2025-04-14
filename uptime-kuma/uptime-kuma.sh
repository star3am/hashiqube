#!/bin/bash

# https://github.com/louislam/uptime-kuma

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Cleanup"
echo -e '\e[38;5;198m'"++++ "

# Check if uptime-kuma container exists before stopping and removing it
if sudo docker ps -a --format '{{.Names}}' | grep -q "^uptime-kuma$"; then
  echo "Stopping and removing uptime-kuma container"
  sudo docker stop uptime-kuma
  sudo docker rm uptime-kuma
fi

# Only prune if needed
echo "Pruning Docker system"
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

echo -e '\e[38;5;198m'"++++ Uptime Kuma: http://localhost:3001/ - Please set up your credentials at first login"
