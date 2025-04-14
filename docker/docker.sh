#/bin/bash
# https://docs.docker.com/install/linux/docker-ce/ubuntu/
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"Installing Docker Dependencies"
echo -e '\e[38;5;198m'"++++ "
sudo DEBIAN_FRONTEND=noninteractive apt-get update -qq < /dev/null > /dev/null
sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq --assume-yes apt-transport-https ca-certificates curl gnupg-agent software-properties-common < /dev/null > /dev/null
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

arch=$(lscpu | grep "Architecture" | awk '{print $NF}')
if [[ $arch == x86_64* ]]; then
  ARCH="amd64"
elif  [[ $arch == aarch64 ]]; then
  ARCH="arm64"
fi
echo -e '\e[38;5;198m'"CPU is $ARCH"

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"Installing Docker"
echo -e '\e[38;5;198m'"++++ "
sudo add-apt-repository -y "deb [arch=$ARCH] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update -qq < /dev/null > /dev/null
# BUG: error reopening /dev/null https://bugs.launchpad.net/ubuntu/+source/docker.io/+bug/1950071 so we pin docker-ce=5:20.10.16~3-0~ubuntu-focal and containerd.io=1.5.11-1
# BUG: https://github.com/containerd/containerd/issues/6203
# FIXED: failed to create shim task: OCI runtime create failed: runc create failed: unable to start container process: error during container init: error reopening /dev/null inside container: open /dev/null: operation not permitted: unknown
sudo DEBIAN_FRONTEND=noninteractive apt-get install -qq --allow-downgrades --assume-yes docker-ce docker-ce-cli containerd.io docker-compose-plugin < /dev/null > /dev/null

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"Set Docker Configs"
echo -e '\e[38;5;198m'"++++ "
sudo usermod -aG docker vagrant
sudo mkdir -p /etc/docker
# https://docs.docker.com/config/daemon/prometheus/
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "metrics-addr": "0.0.0.0:9323",
  "experimental": true,
  "storage-driver": "overlay2",
  "insecure-registries": ["10.9.99.10:5001", "10.9.99.10:5002", "localhost:5001", "localhost:5002"]
}
EOF

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"Restart Docker Daemon"
echo -e '\e[38;5;198m'"++++ "
sudo service docker restart
cd /vagrant/docker

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"Docker System prune"
echo -e '\e[38;5;198m'"++++ "

# Check if containers exist before stopping and removing them
if docker ps -a --format '{{.Names}}' | grep -q "^registry$"; then
  echo "Stopping and removing registry container"
  docker stop registry
  docker rm registry
fi

if docker ps -a --format '{{.Names}}' | grep -q "^apache2$"; then
  echo "Stopping and removing apache2 container"
  docker stop apache2
  docker rm apache2
fi

echo "Pruning Docker system"
yes | sudo docker system prune -a
yes | sudo docker system prune --volumes

# echo -e '\e[38;5;198m'"++++ "
# echo -e '\e[38;5;198m'"Creating Private Docker Registry"
# echo -e '\e[38;5;198m'"++++ "
# # https://docs.docker.com/registry/deploying/#customize-the-published-port
# docker run -d --restart=always \
#   --name registry \
#   -v "$(pwd)"/auth:/auth \
#   -e "REGISTRY_AUTH=htpasswd" \
#   -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
#   -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
#   -e REGISTRY_HTTP_ADDR=0.0.0.0:5002 \
#   --memory 256M -p 5002:5002 registry:2

# Create Docker registry credentials from environment variables
# cat <<EOF | sudo tee /etc/docker/auth.json
# {
#   "username": "${DOCKER_REGISTRY_USER:-admin}",
#   "password": "${DOCKER_REGISTRY_PASSWORD:-$(openssl rand -base64 12)}",
#   "email": "${DOCKER_REGISTRY_EMAIL:-admin@localhost}"
# }
# EOF

# echo -e '\e[38;5;198m'"++++ "
# echo -e '\e[38;5;198m'"++++ Docker Login to Registry"
# echo -e '\e[38;5;198m'"++++ "
# sleep 10;
# DOCKER_REGISTRY_USER=${DOCKER_REGISTRY_USER:-admin}
# DOCKER_REGISTRY_PASSWORD=${DOCKER_REGISTRY_PASSWORD:-$(openssl rand -base64 12)}
# sudo --preserve-env=PATH -u vagrant docker login -u="$DOCKER_REGISTRY_USER" -p="$DOCKER_REGISTRY_PASSWORD" http://10.9.99.10:5002

# echo -e '\e[38;5;198m'"++++ "
# echo -e '\e[38;5;198m'"++++ Docker build -t apache2 ."
# echo -e '\e[38;5;198m'"++++ "
# docker build -t apache2 .

# echo -e '\e[38;5;198m'"++++ "
# echo -e '\e[38;5;198m'"++++ Docker images --filter reference=apache2"
# echo -e '\e[38;5;198m'"++++ "
# docker images --filter reference=apache2

# echo -e '\e[38;5;198m'"++++ "
# echo -e '\e[38;5;198m'"++++ Docker run -t -d -i -p 8889:80 --name apache2 --rm apache2"
# echo -e '\e[38;5;198m'"++++ "
# docker run -t -d -i -p 8889:80 --name apache2 --memory 16M --rm apache2

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Docker ps"
echo -e '\e[38;5;198m'"++++ "
docker ps

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Docker stats"
echo -e '\e[38;5;198m'"++++ "
docker stats --no-stream -a

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Docker Daemon installed"
echo -e '\e[38;5;198m'"++++ "
# echo -e '\e[38;5;198m'"++++ open http://localhost:8889 in your browser"
# echo -e '\e[38;5;198m'"++++ you can also run below to get apache2 version from the docker container"
# echo -e '\e[38;5;198m'"++++ vagrant ssh -c \"docker ps; docker exec -it apache2 /bin/bash -c 'apache2 -t -v; ps aux'\""
