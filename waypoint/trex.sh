#/bin/bash
# https://docs.docker.com/install/linux/docker-ce/ubuntu/

docker stop trex
docker rm trex
yes | sudo docker system prune -a
yes | sudo docker system prune --volumes

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Docker build -t trex ."
echo -e '\e[38;5;198m'"++++ "
cd /vagrant/waypoint/waypoint/custom-examples/trex-nodejs
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
