#!/bin/bash
# https://docs.localstack.cloud/get-started/

sudo usermod -aG docker vagrant
export PATH=$PATH:/root/.local/bin

arch=$(lscpu | grep "Architecture" | awk '{print $NF}')
if [[ $arch == x86_64* ]]; then
  ARCH="amd64"
elif  [[ $arch == aarch64 ]]; then
  ARCH="arm64"
fi
echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ CPU is $ARCH"
echo -e '\e[38;5;198m'"++++ "

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

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Ensure Terraform is installed (Dependency)"
echo -e '\e[38;5;198m'"++++ "
if [[ ! -f /usr/local/bin/terraform ]];
then
  echo -e '\e[38;5;198m'"++++ Terraform is not installed, installing"
  sudo bash /vagrant/terraform/terraform.sh
else
  echo -e '\e[38;5;198m'"++++ Terraform is installed"
fi

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Bring up Localstack"
echo -e '\e[38;5;198m'"++++ "
pip3 install --upgrade awscli-local
sudo rm -rf awscliv2.zip
# https://aws.amazon.com/blogs/developer/aws-cli-v2-now-available-for-linux-arm/ aarch64
curl -s "https://awscli.amazonaws.com/awscli-exe-linux-${arch}.zip" -o "awscliv2.zip"
sudo rm -rf aws
sudo unzip -q awscliv2.zip
yes | sudo ./aws/install --update
echo -e '\e[38;5;198m'"aws --version"
aws --version
python3 -m pip install awscli-local --quiet
python3 -m pip install flask-cors --quiet
sudo -E docker stop localstack_main
yes | sudo docker system prune --volumes
sudo docker run --rm -it -d -p 4566:4566 -p 4571:4571 --rm --privileged --name localstack_main localstack/localstack
sudo docker ps | grep localstack

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Running Terraform Init, Plan and Apply in Localstack directory"
echo -e '\e[38;5;198m'"++++ "
cd /vagrant/localstack/
export PATH=$HOME/.local/bin:$PATH
echo -e '\e[38;5;198m'"++++ Removing previous Terraform state files.."
rm -rf ./terraform.tfstate*
echo -e '\e[38;5;198m'"++++ Terraform init.."
terraform init
echo -e '\e[38;5;198m'"++++ Terraform fmt.."
terraform fmt
echo -e '\e[38;5;198m'"++++ Terraform validate.."
terraform validate
echo -e '\e[38;5;198m'"++++ Terraform plan.."
terraform plan
echo -e '\e[38;5;198m'"++++ Terraform apply.."
terraform apply --auto-approve
echo -e '\e[38;5;198m'"++++ Awslocal s3 ls.."
awslocal s3 ls || true
# echo -e '\e[38;5;198m'"++++ Terraform destroy.."
# terraform destroy --auto-approve
