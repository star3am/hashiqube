#!/bin/bash

# https://github.com/jenkinsci/hashicorp-vault-plugin
# https://www.jenkins.io/doc/book/pipeline/jenkinsfile/

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Cleanup"
echo -e '\e[38;5;198m'"++++ "
sudo docker stop jenkins
sudo docker rm jenkins
yes | sudo docker system prune -a
yes | sudo docker system prune --volumes

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Start Jenkins"
echo -e '\e[38;5;198m'"++++ "
sudo docker run -d -p 8088:8088 -e JENKINS_OPTS="--httpPort=8088" --memory 1024M --restart always --name jenkins -v /var/jenkins_home:/var/jenkins_home jenkins/jenkins:lts
sleep 20

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Check if Hashicorp Vault is running"
echo -e '\e[38;5;198m'"++++ "
if pgrep -x "vault" >/dev/null
then
echo "Vault is running"
else
echo -e '\e[38;5;198m'"++++ Ensure Vault is running.."
sudo bash /vagrant/vault/vault.sh
fi

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ Using the root Vault token, add a Secret in Vault which Jenkins will retrieve"
echo -e '\e[38;5;198m'"++++ "
# add vault ENV variables
VAULT_TOKEN=$(grep 'Initial Root Token' /etc/vault/init.file | cut -d ':' -f2 | tr -d ' ')

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ vault secrets enable -path=kv1 kv1"
echo -e '\e[38;5;198m'"++++ "
vault secrets enable -path=kv1 -version=1 kv

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ vault secrets enable -path=kv2 kv2"
echo -e '\e[38;5;198m'"++++ "
vault secrets enable -path=kv2 -version=2 kv

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ lets add some secrets in kv2/secret using kv put"
echo -e '\e[38;5;198m'"++++ "
vault kv put kv2/secret/another_test another_test="another_test_VALUE"

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ lets list the secrets in kv2/secret using kv get"
echo -e '\e[38;5;198m'"++++ "
vault kv get kv2/secret/another_test

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ lets add some secrets in kv1/secret using kv put"
echo -e '\e[38;5;198m'"++++ "
vault kv put kv1/secret/testing/value_one value_one="ONE"
vault kv put kv1/secret/testing/value_two value_two="TWO"

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ lets list the secrets in kv1/secret/testing using kv get"
echo -e '\e[38;5;198m'"++++ "
vault kv get kv1/secret/testing/value_one
vault kv get kv1/secret/testing/value_two

echo -e '\e[38;5;198m'"++++ "
echo -e '\e[38;5;198m'"++++ To use Jenkins please open in your browser"
echo -e '\e[38;5;198m'"++++ http://localhost:8088"
echo -e '\e[38;5;198m'"++++ Login with username: admin and password: `sudo cat /var/jenkins_home/secrets/initialAdminPassword`"
