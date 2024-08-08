#/bin/bash
# https://docs.docker.com/install/linux/docker-ce/ubuntu/

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Ensure Docker Daemon is running (Dependency)"
echo -e '\e[38;5;198m'"++++ "
if pgrep -x "dockerd" >/dev/null
then
  echo -e '\e[38;5;198m'"++++ Docker is running"
else
  echo -e '\e[38;5;198m'"++++ Ensure Docker is running.."
  sudo bash /vagrant/docker/docker.sh
fi

docker stop trex
docker rm trex
yes | sudo docker system prune -a
yes | sudo docker system prune --volumes

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Docker build -t trex ."
echo -e '\e[38;5;198m'"++++ "
cd /vagrant/trex/trex-nodejs
docker build -t trex .

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Docker images --filter reference=trex"
echo -e '\e[38;5;198m'"++++ "
docker images --filter reference=trex

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Docker run -t -d -i -p 6001:6001 --name trex --rm trex"
echo -e '\e[38;5;198m'"++++ "
docker run -t -d -i -p 6001:6001 --name trex --rm trex

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Docker ps -f name=trex"
echo -e '\e[38;5;198m'"++++ "
docker ps -f name=trex

echo -e '\e[38;5;198m'"++++ Open http://localhost:6001 in your browser"
