# Jenkins

## About

This will help you start the Jenkins container, login with the initial admin token and create a user and password for subsequent logins.

![Jenkins Logo](images/jenkins-logo.png?raw=true "Jenkins Logo")

We will also configure Jenkins to do the following for us: 

- Clone https://github.com/star3am/terraform-hashicorp-hashiqube
- Install https://github.com/aquasecurity/tfsec Aquasec's TFSec and scan our modules
- Install Terraform and run Terraform Plan on Terraform Cloud
- Install Hashicorp Vault Plugin https://github.com/jenkinsci/hashicorp-vault-plugin
After that, we will configure Vault's secret engines, KV store version 1 and 2 and set some keys.

For this demo we will use the Vault root access token for Jenkins access. Other authentication methods like LDAP can be enabled later.

Let's start Jenkins

## Provision

`vagrant up --provision-with basetools,docker,docsify,vault,jenkins`

```log
Bringing machine 'hashiqube0' up with 'docker' provider...
==> hashiqube0: Running provisioner: jenkins (shell)...
    hashiqube0: Running: /var/folders/24/42plvkmn3313qkrvqjr3nqph0000gn/T/vagrant-shell20230919-34426-3boz8s.sh
    hashiqube0: ++++
    hashiqube0: ++++ Cleanup
    hashiqube0: ++++
    hashiqube0: jenkins
    hashiqube0: jenkins
    hashiqube0: WARNING! This will remove:
    hashiqube0:   - all stopped containers
    hashiqube0:   - all networks not used by at least one container
    hashiqube0:   - all images without at least one container associated to them
    hashiqube0:   - all build cache
    hashiqube0:
    hashiqube0: Are you sure you want to continue? [y/N] Deleted Images:
    hashiqube0: untagged: jenkins/jenkins:lts
    hashiqube0: untagged: jenkins/jenkins@sha256:645d55b80126b67dd23b6ba65d455ebc13689d057f498fbecd7bdb9165f0dd64
    hashiqube0: deleted: sha256:153dc2842febbaaf7ec355b2e1aed81fb86d6f729e8cd2988abb31c0119e12a6
    hashiqube0: deleted: sha256:67b3bec8f3b0048fc45b686bd817dc5afc9d3d320cbccdd9eb6c7c1a7a34b9fe
    hashiqube0: deleted: sha256:e0003b10c4fba110263335365bce4178383b4e17d1ce8d238fc79501913e799c
    hashiqube0: deleted: sha256:d8c0828c2b02e62f9bc89cd7144eb817f8fa79d349bad6c9ac279c55ce9e37c3
    hashiqube0: deleted: sha256:a77637500b11fd6f14b99fb8dd34247185495013784c014610d8ff688ade040a
    hashiqube0: deleted: sha256:ef9cc025116423c5ce63bb10ec1809c0bfd06d9b3ac6a7ef00cbabf25dabacaa
    hashiqube0: deleted: sha256:c38e766106bf9642c3654d4e64392c995877de80f5710fdf9d33200f27deb186
    hashiqube0: deleted: sha256:068bc0715e3a8a5a180bc5d855113d9f80b1b1d8a55c233574416f4b246e9dd8
    hashiqube0: deleted: sha256:b424abd7e08081708484151eeefcf03061c7394efa326ad614fcd74d437241dd
    hashiqube0: deleted: sha256:1062a8844ad0a70c4327b0e5cb010ba6641fa7f058d43d6afda201aa46b0ca50
    hashiqube0: deleted: sha256:0f39a3172f8422bab2f1ac65c3eca191fd88562b050c4e1bb84aa2c02e3a1a0c
    hashiqube0: deleted: sha256:14fc155ad2ba67722262e57454da2af35f870d1be9ad7f3abd74598b1e63ce88
    hashiqube0: deleted: sha256:21e3513de08f544772a01396a63e7e4c31c76c5a837078e11fd6c96a0fdee36e
    hashiqube0: deleted: sha256:7806df21f4c455687a53386a856fd9d6164a221c71ce420b7676ed17a6ee4e73
    hashiqube0:
    hashiqube0: Total reclaimed space: 501.6MB
    hashiqube0: WARNING! This will remove:
    hashiqube0:   - all stopped containers
    hashiqube0:   - all networks not used by at least one container
    hashiqube0:   - all anonymous volumes not used by at least one container
    hashiqube0:   - all dangling images
    hashiqube0:   - all dangling build cache
    hashiqube0:
    hashiqube0: Are you sure you want to continue? [y/N] Total reclaimed space: 0B
    hashiqube0: ++++
    hashiqube0: ++++ Start Jenkins
    hashiqube0: ++++
    hashiqube0: Unable to find image 'jenkins/jenkins:lts' locally
    hashiqube0: lts: Pulling from jenkins/jenkins
    hashiqube0: a014e5e7d08c: Pulling fs layer
    hashiqube0: dc791314fcb2: Pulling fs layer
    hashiqube0: 8489857877ae: Pulling fs layer
    hashiqube0: 0351dc37900d: Pulling fs layer
    hashiqube0: f5bd758265a1: Pulling fs layer
    hashiqube0: 9fd567247530: Pulling fs layer
    hashiqube0: 8957e4a59162: Pulling fs layer
    hashiqube0: d0b134b27363: Pulling fs layer
    hashiqube0: a47feec8e894: Pulling fs layer
    hashiqube0: 3e0bbffbb194: Pulling fs layer
    hashiqube0: 6d87c5a3d9ad: Pulling fs layer
    hashiqube0: 239833f8a719: Pulling fs layer
    hashiqube0: fa0ef23b7d19: Pulling fs layer
    hashiqube0: 0351dc37900d: Waiting
    hashiqube0: f5bd758265a1: Waiting
    hashiqube0: 3e0bbffbb194: Waiting
    hashiqube0: 8957e4a59162: Waiting
    hashiqube0: 6d87c5a3d9ad: Waiting
    hashiqube0: fa0ef23b7d19: Waiting
    hashiqube0: d0b134b27363: Waiting
    hashiqube0: a47feec8e894: Waiting
    hashiqube0: 9fd567247530: Waiting
    hashiqube0: 239833f8a719: Waiting
    hashiqube0: 8489857877ae: Verifying Checksum
    hashiqube0: 8489857877ae: Download complete
    hashiqube0: 0351dc37900d: Verifying Checksum
    hashiqube0: 0351dc37900d: Download complete
    hashiqube0: f5bd758265a1: Verifying Checksum
    hashiqube0: f5bd758265a1: Download complete
    hashiqube0: dc791314fcb2: Verifying Checksum
    hashiqube0: dc791314fcb2: Download complete
    hashiqube0: 8957e4a59162: Download complete
    hashiqube0: d0b134b27363: Verifying Checksum
    hashiqube0: d0b134b27363: Download complete
    hashiqube0: a47feec8e894: Verifying Checksum
    hashiqube0: a47feec8e894: Download complete
    hashiqube0: 3e0bbffbb194: Verifying Checksum
    hashiqube0: 3e0bbffbb194: Download complete
    hashiqube0: 9fd567247530: Download complete
    hashiqube0: 6d87c5a3d9ad: Verifying Checksum
    hashiqube0: 6d87c5a3d9ad: Download complete
    hashiqube0: 239833f8a719: Verifying Checksum
    hashiqube0: 239833f8a719: Download complete
    hashiqube0: fa0ef23b7d19: Verifying Checksum
    hashiqube0: fa0ef23b7d19: Download complete
    hashiqube0: a014e5e7d08c: Download complete
    hashiqube0: a014e5e7d08c: Pull complete
    hashiqube0: dc791314fcb2: Pull complete
    hashiqube0: 8489857877ae: Pull complete
    hashiqube0: 0351dc37900d: Pull complete
    hashiqube0: f5bd758265a1: Pull complete
    hashiqube0: 9fd567247530: Pull complete
    hashiqube0: 8957e4a59162: Pull complete
    hashiqube0: d0b134b27363: Pull complete
    hashiqube0: a47feec8e894: Pull complete
    hashiqube0: 3e0bbffbb194: Pull complete
    hashiqube0: 6d87c5a3d9ad: Pull complete
    hashiqube0: 239833f8a719: Pull complete
    hashiqube0: fa0ef23b7d19: Pull complete
    hashiqube0: Digest: sha256:645d55b80126b67dd23b6ba65d455ebc13689d057f498fbecd7bdb9165f0dd64
    hashiqube0: Status: Downloaded newer image for jenkins/jenkins:lts
    hashiqube0: 921e86e94bf7eb1076916cfb67a9a3674e2aee4a6bd82e1d93ecdcf9f8942a9a
    hashiqube0: ++++
    hashiqube0: ++++ Check if Hashicorp Vault is running
    hashiqube0: ++++
    hashiqube0: Vault is running
    hashiqube0: ++++
    hashiqube0: ++++ Using the root Vault token, add a Secret in Vault which Jenkins will retrieve
    hashiqube0: ++++
    hashiqube0: ++++
    hashiqube0: ++++ vault secrets enable -path=kv1 kv1
    hashiqube0: ++++
    hashiqube0: Error enabling: Error making API request.
    hashiqube0:
    hashiqube0: URL: POST http://127.0.0.1:8200/v1/sys/mounts/kv1
    hashiqube0: Code: 400. Errors:
    hashiqube0:
    hashiqube0: * path is already in use at kv1/
    hashiqube0: ++++
    hashiqube0: ++++ vault secrets enable -path=kv2 kv2
    hashiqube0: ++++
    hashiqube0: Error enabling: Error making API request.
    hashiqube0:
    hashiqube0: URL: POST http://127.0.0.1:8200/v1/sys/mounts/kv2
    hashiqube0: Code: 400. Errors:
    hashiqube0:
    hashiqube0: * path is already in use at kv2/
    hashiqube0: ++++
    hashiqube0: ++++ lets add some secrets in kv2/secret using kv put
    hashiqube0: ++++
    hashiqube0: ======== Secret Path ========
    hashiqube0: kv2/data/secret/another_test
    hashiqube0:
    hashiqube0: ======= Metadata =======
    hashiqube0: Key                Value
    hashiqube0: ---                -----
    hashiqube0: created_time       2023-09-19T05:27:33.452862672Z
    hashiqube0: custom_metadata    <nil>
    hashiqube0: deletion_time      n/a
    hashiqube0: destroyed          false
    hashiqube0: version            2
    hashiqube0: ++++
    hashiqube0: ++++ lets list the secrets in kv2/secret using kv get
    hashiqube0: ++++
    hashiqube0: ======== Secret Path ========
    hashiqube0: kv2/data/secret/another_test
    hashiqube0:
    hashiqube0: ======= Metadata =======
    hashiqube0: Key                Value
    hashiqube0: ---                -----
    hashiqube0: created_time       2023-09-19T05:27:33.452862672Z
    hashiqube0: custom_metadata    <nil>
    hashiqube0: deletion_time      n/a
    hashiqube0: destroyed          false
    hashiqube0: version            2
    hashiqube0:
    hashiqube0: ======== Data ========
    hashiqube0: Key             Value
    hashiqube0: ---             -----
    hashiqube0: another_test    another_test_VALUE
    hashiqube0: ++++
    hashiqube0: ++++ lets add some secrets in kv1/secret using kv put
    hashiqube0: ++++
    hashiqube0: Success! Data written to: kv1/secret/testing/value_one
    hashiqube0: Success! Data written to: kv1/secret/testing/value_two
    hashiqube0: ++++
    hashiqube0: ++++ lets list the secrets in kv1/secret/testing using kv get
    hashiqube0: ++++
    hashiqube0: ====== Data ======
    hashiqube0: Key          Value
    hashiqube0: ---          -----
    hashiqube0: value_one    ONE
    hashiqube0: ====== Data ======
    hashiqube0: Key          Value
    hashiqube0: ---          -----
    hashiqube0: value_two    TWO
    hashiqube0: ++++
    hashiqube0: ++++ To use Jenkins please open in your browser
    hashiqube0: ++++ http://localhost:8088
    hashiqube0: ++++ Login with username: admin and password: 050fb849cef940cba7065f10d4d10a8c
```

## Login

Use the token in the output "Login with `4ed0dc30230c4310a58a22207414c3aa`" to login to Jenkins.

![Jenkins](images/jenkins_initial_admin_token_login.png?raw=true "Jenkins")

![Jenkins](images/jenkins_admin_login.png?raw=true "Jenkins")

## Plugins

Install the suggested plugins for Jenkins.

![Jenkins](images/jenkins_install_suggested_plugins.png?raw=true "Jenkins")

Let the plugins download and install, we will install a few others once we are logged in.

Install the suggested plugins for Jenkins.
![Jenkins](images/jenkins_install_suggested_plugins_busy_installing.png?raw=true "Jenkins")

Create the first admin user for Jenkins.
![Jenkins](images/jenkins_create_first_admin_user.png?raw=true "Jenkins")

Click `Save and Finish` for the initial instance configuration setting the Jenkins URL.

![Jenkins](images/jenkins_install_instance_configuration.png?raw=true "Jenkins")

Let's start using Jenkins!

![Jenkins](images/jenkins_start_using_jenkins.png?raw=true "Jenkins")

Now let's install a few more plugins, click on `Manage Jenkins -> Manage Plugins`

![Jenkins](images/jenkins_manage_jenkins_manage_plugins.png?raw=true "Jenkins")

Click on `Available` and search for `HashiCorp Vault` and select it, next search for `Pipeline: Multibranch with defaults` and select that too, now click `Download and Install after Restart` once done and installed, select `Restart Jenkins once Installation is Complete`

![Jenkins](images/jenkins_restart_jenkins_when_plugin_installation_complete.png?raw=true "Jenkins")

Now click top Right `Enable Automatic Refresh` this will take you back to the Jenkins login page, now login with the credentials you created at `Create the first admin user for Jenkins.`

Before we continue let's make sure Vault is running and it is unsealed. In a terminal please run

## Vault

`vagrant up --provision-with vault`
```log
Bringing machine 'user.local.dev' up with 'virtualbox' provider...
==> user.local.dev: Checking if box 'ubuntu/xenial64' version '20190918.0.0' is up to date...
==> user.local.dev: [vagrant-hostsupdater] Checking for host entries
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 consul-user.local.dev
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 vault-user.local.dev
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 nomad-user.local.dev
==> user.local.dev: Running provisioner: vault (shell)...
   user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20191024-26402-1ms4n4s.sh
   user.local.dev: Vault already installed and running
   user.local.dev: Vault http://localhost:8200/ui and enter the following codes displayed below
   user.local.dev: Unseal Key 1: aRBITqqWe57Tl38J9avHZVoow2oC6C2qjEgWFqQAV4Z1
   user.local.dev: Unseal Key 2: +Z0RHNn1lBkKas5WIiuXYha5LTA/7i+ncLBdJafBpNs8
   user.local.dev: Unseal Key 3: 0Wg9qT6rNeB1fm5CDUdEuM8nWtI6Jt5PTAT6z0HkZRBY
   user.local.dev: Unseal Key 4: ysw0/LJPGy4jfhoPG6Lvm+ARBzkT8Q70cXgvPRZRd5Pi
   user.local.dev: Unseal Key 5: g6el6P2RAtwymn8tHE38ltdyiOeEf1Wfn8+8kShxIdZP
   user.local.dev:
   user.local.dev: Initial Root Token: s.XmyUDCIJkHMA4QgeDO6oykz6
   user.local.dev:
   user.local.dev: Vault initialized with 5 key shares and a key threshold of 3. Please securely
   user.local.dev: distribute the key shares printed above. When the Vault is re-sealed,
   user.local.dev: restarted, or stopped, you must supply at least 3 of these keys to unseal it
   user.local.dev: before it can start servicing requests.
   user.local.dev:
   user.local.dev: Vault does not store the generated master key. Without at least 3 key to
   user.local.dev: reconstruct the master key, Vault will remain permanently sealed!
   user.local.dev:
   user.local.dev: It is possible to generate new unseal keys, provided you have a quorum of
   user.local.dev: existing unseal keys shares. See "vault operator rekey" for more information.
```

Now open up `http://localhost:8200`
Vault will start up sealed. We need unseal Vault to use it.

Enter 3 of the 5 Unseal keys printed above, lastly, enter the `Initial Root Token`
You need to be logged into Vault and should see the screen below.

![Vault](images/vault_unsealed_and_logged_in.png?raw=true "Vault")

Now let's enable KV secret engines V1 and V2 and add some data for Jenkins to use.

Click on `Enable new engine +` (Top right)

![Vault](images/vault_enable_secrets_engine_kv.png?raw=true "Vault")

Vault has made a version 2 of the KV secrets engine, to help us distinguish between versions, we will make the path v1 and v2 respectively.

![Vault](images/vault_enable_secrets_engine_kv2.png?raw=true "Vault")

Now that KV v2 has been enabled, let's add some secrets, please click on `Create secret +` (Top right)

Here we now need to reference the Jenkinsfile that I have prepared for you, the following

```groovy
def secrets = [
  [path: 'kv2/secret/another_test', engineVersion: 2, secretValues: [
  [vaultKey: 'another_test']]]
  [path: 'kv1/secret/testing', engineVersion: 1, secretValues: [
  [envVar: 'testing', vaultKey: 'value_one'],
  [envVar: 'testing_again', vaultKey: 'value_two']]]
]
```

Add as the path `secret/another_test` and as the key `another_test` with some data of your choice.

![Vault](images/vault_enable_secrets_engine_kv2_secret_another_test.png?raw=true "Vault")

Also enable KV v1

![Vault](images/vault_enable_secrets_engine_kv1.png?raw=true "Vault")

And set the keys below

```sh
Path: secret/testing
Key: value_one Value: Any data of your choice for Vault KV v1 value_one
Key: value_two Value: Any data of your choice for Vault KV v1 value_two
```

![Vault](images/vault_enable_secrets_engine_kv1_secret_value_one_and_value_two.png?raw=true "Vault")

Now let's connect Jenkins with Vault.

In Jenkins, click on `Manage Jenkins -> Configure System` and scroll down to Vault.

![Jenkins](images/jenkins_manage_jenkins_configure_system_vault.png?raw=true "Jenkins")

For Vault address use `http://10.9.99.10:8200` The IP Address is set in the Vagrantfile in the `machines {}`

Click `Skip SSL Validation` for this demo.

Now we need to add the Vault root token for Jenkins to communicate with Vault

![Jenkins](images/jenkins_manage_jenkins_configure_system_vault_initial_root_token.png?raw=true "Jenkins")

## Terraform Cloud

Now we can create our first Jenkins job!

But let's quickly add the Token for Terraform Cloud.

Please got to https://app.terraform.io/ and sign up for a Free Account!! No Credit Card Needed!!

![Terraform Cloud](images/terraform-cloud-sign-up-for-free-account.png?raw=true "Terraform Cloud")

Now we will create the workspace in Terraform Cloud, mine is called `terraform-hashicorp-hashiqube`

![Terraform Cloud Workspace](images/terraform-cloud-workspace.png?raw=true "Terraform Cloud Workspace")

And lastly we need to create a Terraform Cloud Token that Jenkins will use to Authenticate to your Terraform Cloud instance and do a plan / apply on your workspace

![Terraform Cloud Token](images/terraform-cloud-token.png?raw=true "Terraform Cloud Token")

## Credential

Now we can add this Token as a `Secret Text` in Jenkins Credential Manager

![Jenkins Credential Secret Text Terraform Cloud Token](images/jenkins_credential-secret-text.png?raw=true "Jenkins Credential Secret Text Terraform Cloud Token")

## Jenkinsfile pipeline

Jenkinsfile pipeline example that runs Terraform and retrieve secrets from Vault

In Jenkins click on `New Item -> Pipeline` and give it a name, I used `vault-jenkins` and click apply.
Scroll down until you get to the pipeline definition and enter the following data (it is the Jenkinsfile in the jenkins directory)

Be sure to update the relevant Terraform Cloud part of the Jenkinsfile

`YOUR_CREDENTIALS_ID`

`YOUR_TF_CLOUD_ORGANIZATION`

`YOUR_TF_WORKSPACE_NAME`

```groovy
  stage('Create Backend Config for Terraform Cloud') {
    withCredentials([string(credentialsId: 'YOUR_CREDENTIALS_ID', variable: 'SECRET')]) {
      sh """
        cat <<EOF | tee backend.tf
terraform {
  cloud {
    organization = "YOUR_TF_CLOUD_ORGANIZATION"
    workspaces {
      name = "YOUR_TF_WORKSPACE"
    }
    token = "${SECRET}"
  }
}
EOF
      """
    }
  }
```

And below is the `Jenkinsfile`

```groovy
// https://github.com/jenkinsci/hashicorp-vault-plugin
// https://www.jenkins.io/doc/book/pipeline/jenkinsfile/

import hudson.model.Job
import jenkins.scm.api.mixin.ChangeRequestSCMHead
import jenkins.scm.api.mixin.TagSCMHead
import org.jenkinsci.plugins.workflow.multibranch.BranchJobProperty

node {
  properties([disableConcurrentBuilds()])

  stage('Checkout https://github.com/star3am/terraform-hashicorp-hashiqube') {
    git(
      url: "https://github.com/star3am/terraform-hashicorp-hashiqube.git",
      branch: "master",
      changelog: true,
      poll: true
    )
  }

  stage('Echo Variables') {
    echo "JOB_NAME: ${env.JOB_NAME}"
    echo "BUILD_ID: ${env.BUILD_ID}"
    echo "BUILD_NUMBER: ${env.BUILD_NUMBER}"
    echo "BRANCH_NAME: ${env.BRANCH_NAME}"
    echo "PULL_REQUEST: ${env.CHANGE_ID}"
    echo "BUILD_NUMBER: ${env.BUILD_NUMBER}"
    echo "BUILD_URL: ${env.BUILD_URL}"
    echo "NODE_NAME: ${env.NODE_NAME}"
    echo "BUILD_TAG: ${env.BUILD_TAG}"
    echo "JENKINS_URL: ${env.JENKINS_URL}"
    echo "EXECUTOR_NUMBER: ${env.EXECUTOR_NUMBER}"
    echo "WORKSPACE: ${env.WORKSPACE}"
    echo "GIT_COMMIT: ${env.GIT_COMMIT}"
    echo "GIT_URL: ${env.GIT_URL}"
    echo "GIT_BRANCH: ${env.GIT_BRANCH}"
    LAST_COMMIT_MSG = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%s'")
    echo "LAST_COMMIT_MSG: ${LAST_COMMIT_MSG}"
    env.ARCH = sh(returnStdout: true, script: "lscpu | grep 'Architecture' | tr -s ' ' | cut -d ' ' -f 2 | tr -d '[:space:]'")
    echo "ARCH: ${env.ARCH}"
    env.PATH = "${env.PATH}:${env.WORKSPACE}/bin"
    env.TF_CLI_ARGS = "-no-color"
    echo sh(script: 'env|sort', returnStdout: true)
    sh('echo $(hostname)')
  }

  stage('Create Backend Config for Terraform Cloud') {
    withCredentials([string(credentialsId: 'YOUR_CREDENTIALS_ID', variable: 'SECRET')]) {
      sh """
        cat <<EOF | tee backend.tf
terraform {
  cloud {
    organization = "YOUR_TF_CLOUD_ORGANIZATION"
    workspaces {
      name = "YOUR_TF_WORKSPACE"
    }
    token = "${SECRET}"
  }
}
EOF
      """
    }
  }

  stage('Install Dependencies') {
    sh """
      pwd
      mkdir -p bin
    """
    if (env.ARCH == "x86_64*") {
      script {
        env.arch = "amd64"
        echo "${env.arch}"
      }
    }
    if (env.ARCH == 'aarch64') {
      script {
        env.arch = "arm64"
        echo "${env.arch}"
      }
    }
    sh """
      curl -s "https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_${env.arch}.zip" --output bin/terraform.zip
      (cd bin && unzip -o terraform.zip)
      curl -Lso bin/tfsec "https://github.com/aquasecurity/tfsec/releases/download/v1.28.4/tfsec-linux-${env.arch}"
      chmod +x bin/tfsec
      pwd
      ls -la
      ls -la bin/
      terraform -v
      echo "${env.arch}"
      echo "${env.PATH}"
    """
  }

  stage('Run Aquasecurity TFSec') {
    sh('tfsec ./modules --no-color --soft-fail')
  }

  stage('Run Terraform init') {
    sh('terraform init')
  }

  stage('Run Terraform plan on Terraform Cloud') {
    sh('terraform plan')
  }

  stage('Get ENV vars from Vault') {
    // define the secrets and the env variables
    // engine version can be defined on secret, job, folder or global.
    // the default is engine version 2 unless otherwise specified globally.
    def secrets = [
      [path: 'kv2/secret/another_test', engineVersion: 2, secretValues: [
      [vaultKey: 'another_test']]],
      [path: 'kv1/secret/testing/value_one', engineVersion: 1, secretValues: [
      [vaultKey: 'value_one']]],
      [path: 'kv1/secret/testing/value_two', engineVersion: 1, secretValues: [
      [envVar: 'my_var', vaultKey: 'value_two']]]
    ]

    // optional configuration, if you do not provide this the next higher configuration
    // (e.g. folder or global) will be used
    def configuration = [vaultUrl: 'http://10.9.99.10:8200',
      vaultCredentialId: 'vault-initial-root-token',
      engineVersion: 1]

    // inside this block your credentials will be available as env variables
    withVault([configuration: configuration, vaultSecrets: secrets]) {
      sh 'echo $value_one'
      sh 'echo $my_var'
      sh 'echo $another_test'
    }
  }

  stage('Echo some ENV vars') {
    withCredentials([[$class: 'VaultTokenCredentialBinding', credentialsId: 'vault-initial-root-token', vaultAddr: 'http://10.9.99.10:8200']]) {
      // values will be masked
      sh 'echo TOKEN=$VAULT_TOKEN'
      sh 'echo ADDR=$VAULT_ADDR'
    }
    echo sh(script: 'env|sort', returnStdout: true)
  }
}
```

![Jenkins](images/jenkins_new_item_pipeline_vault-jenkins_configure.png?raw=true "Jenkins")

Click Save.

## Job

Now let's build the job, click on `Build Now` (Right menu) You should see bottom left a successful build.
![Jenkins](images/jenkins_job_vault-jenkins_build.png?raw=true "Jenkins")

## Output

The Jenkins Console log output will look like, you will see that the job clones a repository, runs Aquasec's TFSec and run a Terraform Plan on Terraform Cloud, and finally fetches secrets from Vault

```log
Started by user admin
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/jenkins_home/workspace/test
[Pipeline] {
[Pipeline] properties
[Pipeline] stage
[Pipeline] { (Checkout https://github.com/star3am/terraform-hashicorp-hashiqube) (Checkout https://github.com/star3am/terraform-hashicorp-hashiqube)
[Pipeline] git
The recommended git tool is: NONE
No credentials specified
 > git rev-parse --resolve-git-dir /var/jenkins_home/workspace/test/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/star3am/terraform-hashicorp-hashiqube.git # timeout=10
Fetching upstream changes from https://github.com/star3am/terraform-hashicorp-hashiqube.git
 > git --version # timeout=10
 > git --version # 'git version 2.39.2'
 > git fetch --tags --force --progress -- https://github.com/star3am/terraform-hashicorp-hashiqube.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
Checking out Revision f349e85ae20b5b8a4728257ada983081a2fae122 (refs/remotes/origin/master)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f f349e85ae20b5b8a4728257ada983081a2fae122 # timeout=10
 > git branch -a -v --no-abbrev # timeout=10
 > git branch -D master # timeout=10
 > git checkout -b master f349e85ae20b5b8a4728257ada983081a2fae122 # timeout=10
Commit message: "Merge pull request #20 from star3am/feature/run-dot-sh-without-make"
 > git rev-list --no-walk f349e85ae20b5b8a4728257ada983081a2fae122 # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Echo Variables)
[Pipeline] echo
JOB_NAME: test
[Pipeline] echo
BUILD_ID: 109
[Pipeline] echo
BUILD_NUMBER: 109
[Pipeline] echo
BRANCH_NAME: null
[Pipeline] echo
PULL_REQUEST: null
[Pipeline] echo
BUILD_NUMBER: 109
[Pipeline] echo
BUILD_URL: http://localhost:8088/job/test/109/
[Pipeline] echo
NODE_NAME: built-in
[Pipeline] echo
BUILD_TAG: jenkins-test-109
[Pipeline] echo
JENKINS_URL: http://localhost:8088/
[Pipeline] echo
EXECUTOR_NUMBER: 1
[Pipeline] echo
WORKSPACE: /var/jenkins_home/workspace/test
[Pipeline] echo
GIT_COMMIT: null
[Pipeline] echo
GIT_URL: null
[Pipeline] echo
GIT_BRANCH: null
[Pipeline] sh
+ git log -n 1 --pretty=format:%s
[Pipeline] echo
LAST_COMMIT_MSG: Merge pull request #20 from star3am/feature/run-dot-sh-without-make
[Pipeline] sh
+ + + + + lscpu
grep Architecturetr -scut -dtr -d
  
   -f [:space:]
 2
[Pipeline] echo
ARCH: aarch64
[Pipeline] sh
+ + env
sort
[Pipeline] echo
ARCH=aarch64
BUILD_DISPLAY_NAME=#109
BUILD_ID=109
BUILD_NUMBER=109
BUILD_TAG=jenkins-test-109
BUILD_URL=http://localhost:8088/job/test/109/
CI=true
COPY_REFERENCE_FILE_LOG=/var/jenkins_home/copy_reference_file.log
EXECUTOR_NUMBER=1
HOME=/var/jenkins_home
HOSTNAME=921e86e94bf7
HUDSON_COOKIE=e24d28a6-833a-4910-9c31-8aac5da09de3
HUDSON_HOME=/var/jenkins_home
HUDSON_SERVER_COOKIE=79aead07081a8d8a
HUDSON_URL=http://localhost:8088/
JAVA_HOME=/opt/java/openjdk
JENKINS_HOME=/var/jenkins_home
JENKINS_INCREMENTALS_REPO_MIRROR=https://repo.jenkins-ci.org/incrementals
JENKINS_NODE_COOKIE=0bb2b8ee-e9b8-4ce0-b282-2fecbd036465
JENKINS_OPTS=--httpPort=8088
JENKINS_SERVER_COOKIE=durable-7190c2fadc48570bd1d6b9ff3df70884d6b72f619c1a447143f9aae059f70e9f
JENKINS_SLAVE_AGENT_PORT=50000
JENKINS_UC=https://updates.jenkins.io
JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental
JENKINS_URL=http://localhost:8088/
JENKINS_VERSION=2.414.1
JOB_BASE_NAME=test
JOB_DISPLAY_URL=http://localhost:8088/job/test/display/redirect
JOB_NAME=test
JOB_URL=http://localhost:8088/job/test/
LANG=C.UTF-8
NODE_LABELS=built-in
NODE_NAME=built-in
PATH=/opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/jenkins_home/workspace/test/bin
PWD=/var/jenkins_home/workspace/test
REF=/usr/share/jenkins/ref
RUN_ARTIFACTS_DISPLAY_URL=http://localhost:8088/job/test/109/display/redirect?page=artifacts
RUN_CHANGES_DISPLAY_URL=http://localhost:8088/job/test/109/display/redirect?page=changes
RUN_DISPLAY_URL=http://localhost:8088/job/test/109/display/redirect
RUN_TESTS_DISPLAY_URL=http://localhost:8088/job/test/109/display/redirect?page=tests
SHLVL=0
STAGE_NAME=Echo Variables
TF_CLI_ARGS=-no-color
WORKSPACE=/var/jenkins_home/workspace/test
WORKSPACE_TMP=/var/jenkins_home/workspace/test@tmp

[Pipeline] sh
+ hostname
+ echo 921e86e94bf7
921e86e94bf7
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Create Backend Config for Terraform Cloud)
[Pipeline] withCredentials
Masking supported pattern matches of $SECRET
[Pipeline] {
[Pipeline] sh
Warning: A secret was passed to "sh" using Groovy String interpolation, which is insecure.
		 Affected argument(s) used the following variable(s): [SECRET]
		 See https://jenkins.io/redirect/groovy-string-interpolation for details.
+ + teecat
 backend.tf
terraform {
  cloud {
    organization = "nolan"
    workspaces {
      name = "terraform-hashicorp-hashiqube"
    }
    token = "****"
  }
}
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Install Dependencies)
[Pipeline] sh
+ pwd
/var/jenkins_home/workspace/test
+ mkdir -p bin
[Pipeline] script
[Pipeline] {
[Pipeline] echo
arm64
[Pipeline] }
[Pipeline] // script
[Pipeline] sh
+ curl -s https://releases.hashicorp.com/terraform/1.5.7/terraform_1.5.7_linux_arm64.zip --output bin/terraform.zip
+ cd bin
+ unzip -o terraform.zip
Archive:  terraform.zip
  inflating: terraform               
+ curl -Lso bin/tfsec https://github.com/aquasecurity/tfsec/releases/download/v1.28.4/tfsec-linux-arm64
+ chmod +x bin/tfsec
+ pwd
/var/jenkins_home/workspace/test
+ ls -la
total 204
drwxr-xr-x 33 jenkins jenkins  1056 Sep 20 00:19 .
drwxr-xr-x  7 jenkins jenkins   224 Sep 19 23:07 ..
drwxr-xr-x  3 jenkins jenkins    96 Sep 19 05:07 .devcontainer
-rw-r--r--  1 jenkins jenkins   246 Sep 19 05:07 .dockerignore
drwxr-xr-x 14 jenkins jenkins   448 Sep 20 01:16 .git
drwxr-xr-x  3 jenkins jenkins    96 Sep 19 05:07 .github
-rw-r--r--  1 jenkins jenkins  1036 Sep 19 05:07 .gitignore
-rw-r--r--  1 jenkins jenkins  3214 Sep 19 05:07 .gitlab-ci.yml
-rw-r--r--  1 jenkins jenkins  2319 Sep 19 05:07 .pre-commit-config.yaml
drwxr-xr-x  6 jenkins jenkins   192 Sep 20 00:22 .terraform
-rw-r--r--  1 jenkins jenkins     6 Sep 19 05:07 .terraform-version
-rw-r--r--  1 jenkins jenkins  6798 Sep 19 05:07 .terraform.lock.hcl
-rw-r--r--  1 jenkins jenkins     7 Sep 19 05:07 .terragrunt-version
-rw-r--r--  1 jenkins jenkins   970 Sep 19 05:07 .tflint.hcl
-rw-r--r--  1 jenkins jenkins  2539 Sep 19 05:07 .yamllint
-rw-r--r--  1 jenkins jenkins  7406 Sep 19 07:36 Dockerfile
-rw-r--r--  1 jenkins jenkins  1063 Sep 19 05:07 LICENSE
-rw-r--r--  1 jenkins jenkins  4189 Sep 19 05:07 Makefile
-rw-r--r--  1 jenkins jenkins 85703 Sep 19 05:07 README.md
-rw-r--r--  1 jenkins jenkins   226 Sep 20 00:13 backend.hcl
-rw-r--r--  1 jenkins jenkins   228 Sep 20 01:16 backend.tf
drwxr-xr-x  5 jenkins jenkins   160 Sep 20 01:16 bin
-rw-r--r--  1 jenkins jenkins  1274 Sep 19 05:07 docker-compose.yml
drwxr-xr-x  5 jenkins jenkins   160 Sep 19 05:07 examples
drwxr-xr-x 16 jenkins jenkins   512 Sep 19 05:07 images
-rw-r--r--  1 jenkins jenkins  8401 Sep 19 05:07 main.tf
drwxr-xr-x  6 jenkins jenkins   192 Sep 19 05:07 modules
-rw-r--r--  1 jenkins jenkins  8490 Sep 19 05:07 outputs.tf
-rwxr-xr-x  1 jenkins jenkins   593 Sep 19 23:27 run-without-make.sh
-rwxr-xr-x  1 jenkins jenkins   373 Sep 19 05:07 run.sh
-rw-r--r--  1 jenkins jenkins   210 Sep 19 05:07 terraform.auto.tfvars.example
-rw-r--r--  1 jenkins jenkins   241 Sep 19 05:07 terragrunt.hcl
-rw-r--r--  1 jenkins jenkins  4175 Sep 19 05:07 variables.tf
+ ls -la bin/
total 124800
drwxr-xr-x  5 jenkins jenkins      160 Sep 20 01:16 .
drwxr-xr-x 33 jenkins jenkins     1056 Sep 20 00:19 ..
-rwxr-xr-x  1 jenkins jenkins 61931520 Sep  7 18:19 terraform
-rw-r--r--  1 jenkins jenkins 19074897 Sep 20 01:16 terraform.zip
-rwxr-xr-x  1 jenkins jenkins 44892160 Sep 20 01:16 tfsec
+ terraform -v
Terraform v1.5.7
on linux_arm64
+ provider registry.terraform.io/hashicorp/aws v4.67.0
+ provider registry.terraform.io/hashicorp/azurerm v3.57.0
+ provider registry.terraform.io/hashicorp/external v2.3.1
+ provider registry.terraform.io/hashicorp/google v4.79.0
+ provider registry.terraform.io/hashicorp/http v3.4.0
+ provider registry.terraform.io/hashicorp/null v3.2.1
+ echo arm64
arm64
+ echo /opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/jenkins_home/workspace/test/bin
/opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/jenkins_home/workspace/test/bin
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Run Aquasecurity TFSec)
[Pipeline] sh
+ tfsec ./modules --no-color --soft-fail

======================================================
tfsec is joining the Trivy family

tfsec will continue to remain available 
for the time being, although our engineering 
attention will be directed at Trivy going forward.

You can read more here: 
https://github.com/aquasecurity/tfsec/discussions/1994
======================================================

Result #1 CRITICAL Security group rule allows egress to multiple public internet addresses. 
────────────────────────────────────────────────────────────────────────────────
  aws-hashiqube/main.tf:142
────────────────────────────────────────────────────────────────────────────────
  121    resource "aws_security_group" "hashiqube" {
  ...  
  142  [     cidr_blocks = ["0.0.0.0/0"] #tfsec:ignore:aws-vpc-no-public-egress-sg
  ...  
  145    }
────────────────────────────────────────────────────────────────────────────────
          ID aws-ec2-no-public-egress-sgr
      Impact Your port is egressing data to the internet
  Resolution Set a more restrictive cidr range

  More Information
  - https://aquasecurity.github.io/tfsec/v1.28.4/checks/aws/ec2/no-public-egress-sgr/
  - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group
────────────────────────────────────────────────────────────────────────────────


Result #2 HIGH Instance does not require IMDS access to require a token 
────────────────────────────────────────────────────────────────────────────────
  aws-hashiqube/main.tf:101-103
────────────────────────────────────────────────────────────────────────────────
   96    resource "aws_instance" "hashiqube" {
   ..  
  101  ┌   metadata_options {
  102  │     http_endpoint = "enabled"
  103  └   }
  ...  
  114    }
────────────────────────────────────────────────────────────────────────────────
          ID aws-ec2-enforce-http-token-imds
      Impact Instance metadata service can be interacted with freely
  Resolution Enable HTTP token requirement for IMDS

  More Information
  - https://aquasecurity.github.io/tfsec/v1.28.4/checks/aws/ec2/enforce-http-token-imds/
  - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#metadata-options
────────────────────────────────────────────────────────────────────────────────


Result #3 HIGH Root block device is not encrypted. 
────────────────────────────────────────────────────────────────────────────────
  aws-hashiqube/main.tf:96-114
────────────────────────────────────────────────────────────────────────────────
   96  ┌ resource "aws_instance" "hashiqube" {
   97  │   ami             = data.aws_ami.ubuntu.id
   98  │   instance_type   = var.aws_instance_type
   99  │   security_groups = [aws_security_group.hashiqube.name]
  100  │   key_name        = aws_key_pair.hashiqube.key_name
  101  │   metadata_options {
  102  │     http_endpoint = "enabled"
  103  │   }
  104  └   user_data_base64 = base64gzip(templatefile("${path.module}/../../modules/shared/startup_script", {
  ...  
────────────────────────────────────────────────────────────────────────────────
          ID aws-ec2-enable-at-rest-encryption
      Impact The block device could be compromised and read from
  Resolution Turn on encryption for all block devices

  More Information
  - https://aquasecurity.github.io/tfsec/v1.28.4/checks/aws/ec2/enable-at-rest-encryption/
  - https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance#ebs-ephemeral-and-root-block-devices
────────────────────────────────────────────────────────────────────────────────


  timings
  ──────────────────────────────────────────
  disk i/o             8.962499ms
  parsing              6.287458ms
  adaptation           164.298793ms
  checks               548.342043ms
  total                727.890793ms

  counts
  ──────────────────────────────────────────
  modules downloaded   0
  modules processed    4
  blocks processed     118
  files read           12

  results
  ──────────────────────────────────────────
  passed               46
  ignored              2
  critical             1
  high                 2
  medium               0
  low                  0

  46 passed, 2 ignored, 3 potential problem(s) detected.

[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Run Terraform init)
[Pipeline] sh
+ terraform init

Initializing Terraform Cloud...
Initializing modules...

Initializing provider plugins...
- Reusing previous version of hashicorp/null from the dependency lock file
- Reusing previous version of hashicorp/external from the dependency lock file
- Reusing previous version of hashicorp/http from the dependency lock file
- Reusing previous version of hashicorp/aws from the dependency lock file
- Reusing previous version of hashicorp/azurerm from the dependency lock file
- Reusing previous version of hashicorp/google from the dependency lock file
- Using previously-installed hashicorp/null v3.2.1
- Using previously-installed hashicorp/external v2.3.1
- Using previously-installed hashicorp/http v3.4.0
- Using previously-installed hashicorp/aws v4.67.0
- Using previously-installed hashicorp/azurerm v3.57.0
- Using previously-installed hashicorp/google v4.79.0

Terraform Cloud has been successfully initialized!

You may now begin working with Terraform Cloud. Try running "terraform plan" to
see any changes that are required for your infrastructure.

If you ever set or change modules or Terraform Settings, run "terraform init"
again to reinitialize your working directory.
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Run Terraform plan on Terraform Cloud)
[Pipeline] sh
+ terraform plan
Running plan in Terraform Cloud. Output will stream here. Pressing Ctrl-C
will stop streaming the logs, but will not stop the plan running remotely.

Preparing the remote plan...

To view this run in a browser, visit:
https://app.terraform.io/app/nolan/terraform-hashicorp-hashiqube/runs/run-i3YuH5z92kdbqETW

Waiting for the plan to start...

Terraform v1.5.2
on linux_amd64
Initializing plugins and modules...
data.external.myipaddress: Reading...
data.http.terraform_cloud_ip_ranges: Reading...
data.http.terraform_cloud_ip_ranges: Read complete after 0s [id=https://app.terraform.io/api/meta/ip-ranges]
module.gcp_hashiqube[0].data.google_compute_subnetwork.hashiqube: Reading...
data.external.myipaddress: Read complete after 0s [id=-]
module.aws_hashiqube[0].data.aws_ami.ubuntu: Reading...
module.gcp_hashiqube[0].data.google_compute_subnetwork.hashiqube: Read complete after 2s [id=projects/riaan-nolan-368709/regions/australia-southeast1/subnetworks/default]
module.aws_hashiqube[0].data.aws_ami.ubuntu: Read complete after 1s [id=ami-0a9fb81cc3289919c]

Terraform used the selected providers to generate the following execution
plan. Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # null_resource.hashiqube will be created
  + resource "null_resource" "hashiqube" {
      + id       = (known after apply)
      + triggers = {
          + "debug_user_data"      = "true"
          + "deploy_to_aws"        = "true"
          + "deploy_to_azure"      = "true"
          + "deploy_to_gcp"        = "true"
          + "my_ipaddress"         = "3.235.124.156"
          + "vagrant_provisioners" = "basetools,docker,consul,vault,nomad,boundary,waypoint"
        }
    }

  # module.aws_hashiqube[0].aws_eip.hashiqube will be created
  + resource "aws_eip" "hashiqube" {
      + allocation_id        = (known after apply)
      + association_id       = (known after apply)
      + carrier_ip           = (known after apply)
      + customer_owned_ip    = (known after apply)
      + domain               = (known after apply)
      + id                   = (known after apply)
      + instance             = (known after apply)
      + network_border_group = (known after apply)
      + network_interface    = (known after apply)
      + private_dns          = (known after apply)
      + private_ip           = (known after apply)
      + public_dns           = (known after apply)
      + public_ip            = (known after apply)
      + public_ipv4_pool     = (known after apply)
      + tags_all             = (known after apply)
      + vpc                  = true
    }

  # module.aws_hashiqube[0].aws_eip_association.eip_assoc will be created
  + resource "aws_eip_association" "eip_assoc" {
      + allocation_id        = (known after apply)
      + id                   = (known after apply)
      + instance_id          = (known after apply)
      + network_interface_id = (known after apply)
      + private_ip_address   = (known after apply)
      + public_ip            = (known after apply)
    }

  # module.aws_hashiqube[0].aws_iam_instance_profile.hashiqube will be created
  + resource "aws_iam_instance_profile" "hashiqube" {
      + arn         = (known after apply)
      + create_date = (known after apply)
      + id          = (known after apply)
      + name        = "hashiqube"
      + name_prefix = (known after apply)
      + path        = "/"
      + role        = "hashiqube"
      + tags_all    = (known after apply)
      + unique_id   = (known after apply)
    }

  # module.aws_hashiqube[0].aws_iam_role.hashiqube will be created
  + resource "aws_iam_role" "hashiqube" {
      + arn                   = (known after apply)
      + assume_role_policy    = jsonencode(
            {
              + Statement = [
                  + {
                      + Action    = "sts:AssumeRole"
                      + Effect    = "Allow"
                      + Principal = {
                          + Service = "ec2.amazonaws.com"
                        }
                      + Sid       = ""
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + create_date           = (known after apply)
      + force_detach_policies = false
      + id                    = (known after apply)
      + managed_policy_arns   = (known after apply)
      + max_session_duration  = 3600
      + name                  = "hashiqube"
      + name_prefix           = (known after apply)
      + path                  = "/"
      + role_last_used        = (known after apply)
      + tags_all              = (known after apply)
      + unique_id             = (known after apply)
    }

  # module.aws_hashiqube[0].aws_iam_role_policy.hashiqube will be created
  + resource "aws_iam_role_policy" "hashiqube" {
      + id     = (known after apply)
      + name   = "hashiqube"
      + policy = jsonencode(
            {
              + Statement = [
                  + {
                      + Action   = [
                          + "ec2:Describe*",
                        ]
                      + Effect   = "Allow"
                      + Resource = "*"
                    },
                ]
              + Version   = "2012-10-17"
            }
        )
      + role   = (known after apply)
    }

  # module.aws_hashiqube[0].aws_instance.hashiqube will be created
  + resource "aws_instance" "hashiqube" {
      + ami                                  = "ami-0a9fb81cc3289919c"
      + arn                                  = (known after apply)
      + associate_public_ip_address          = (known after apply)
      + availability_zone                    = (known after apply)
      + cpu_core_count                       = (known after apply)
      + cpu_threads_per_core                 = (known after apply)
      + disable_api_stop                     = (known after apply)
      + disable_api_termination              = (known after apply)
      + ebs_optimized                        = (known after apply)
      + get_password_data                    = false
      + host_id                              = (known after apply)
      + host_resource_group_arn              = (known after apply)
      + iam_instance_profile                 = "hashiqube"
      + id                                   = (known after apply)
      + instance_initiated_shutdown_behavior = (known after apply)
      + instance_state                       = (known after apply)
      + instance_type                        = "t2.medium"
      + ipv6_address_count                   = (known after apply)
      + ipv6_addresses                       = (known after apply)
      + key_name                             = "hashiqube"
      + monitoring                           = (known after apply)
      + outpost_arn                          = (known after apply)
      + password_data                        = (known after apply)
      + placement_group                      = (known after apply)
      + placement_partition_number           = (known after apply)
      + primary_network_interface_id         = (known after apply)
      + private_dns                          = (known after apply)
      + private_ip                           = (known after apply)
      + public_dns                           = (known after apply)
      + public_ip                            = (known after apply)
      + secondary_private_ips                = (known after apply)
      + security_groups                      = [
          + "hashiqube",
        ]
      + source_dest_check                    = true
      + subnet_id                            = (known after apply)
      + tags                                 = {
          + "Name" = "hashiqube"
        }
      + tags_all                             = {
          + "Name" = "hashiqube"
        }
      + tenancy                              = (known after apply)
      + user_data                            = (known after apply)
      + user_data_base64                     = (known after apply)
      + user_data_replace_on_change          = false
      + vpc_security_group_ids               = (known after apply)

      + metadata_options {
          + http_endpoint               = "enabled"
          + http_put_response_hop_limit = (known after apply)
          + http_tokens                 = (known after apply)
          + instance_metadata_tags      = (known after apply)
        }
    }

  # module.aws_hashiqube[0].aws_key_pair.hashiqube will be created
  + resource "aws_key_pair" "hashiqube" {
      + arn             = (known after apply)
      + fingerprint     = (known after apply)
      + id              = (known after apply)
      + key_name        = "hashiqube"
      + key_name_prefix = (known after apply)
      + key_pair_id     = (known after apply)
      + key_type        = (known after apply)
      + public_key      = (sensitive value)
      + tags_all        = (known after apply)
    }

  # module.aws_hashiqube[0].aws_security_group.hashiqube will be created
  + resource "aws_security_group" "hashiqube" {
      + arn                    = (known after apply)
      + description            = "Allow Your Whitelist CIDR addresses"
      + egress                 = [
          + {
              + cidr_blocks      = [
                  + "0.0.0.0/0",
                ]
              + description      = "Allow Your Public IP address"
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "-1"
              + security_groups  = []
              + self             = false
              + to_port          = 0
            },
        ]
      + id                     = (known after apply)
      + ingress                = [
          + {
              + cidr_blocks      = [
                  + "3.235.124.156/32",
                ]
              + description      = "Allow Your Public IP address"
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "tcp"
              + security_groups  = []
              + self             = false
              + to_port          = 65535
            },
          + {
              + cidr_blocks      = [
                  + "3.235.124.156/32",
                ]
              + description      = "Allow Your Public IP address"
              + from_port        = 0
              + ipv6_cidr_blocks = []
              + prefix_list_ids  = []
              + protocol         = "udp"
              + security_groups  = []
              + self             = false
              + to_port          = 65535
            },
        ]
      + name                   = "hashiqube"
      + name_prefix            = (known after apply)
      + owner_id               = (known after apply)
      + revoke_rules_on_delete = false
      + tags_all               = (known after apply)
      + vpc_id                 = (known after apply)
    }

  # module.aws_hashiqube[0].aws_security_group_rule.aws_hashiqube[0] will be created
  + resource "aws_security_group_rule" "aws_hashiqube" {
      + cidr_blocks              = (known after apply)
      + description              = "Allow Hashiqube Public IP address"
      + from_port                = 0
      + id                       = (known after apply)
      + protocol                 = "-1"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 65535
      + type                     = "ingress"
    }

  # module.aws_hashiqube[0].aws_security_group_rule.azure_hashiqube[0] will be created
  + resource "aws_security_group_rule" "azure_hashiqube" {
      + cidr_blocks              = (known after apply)
      + description              = "Allow Azure Hashiqube Public IP address"
      + from_port                = 0
      + id                       = (known after apply)
      + protocol                 = "-1"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 65535
      + type                     = "ingress"
    }

  # module.aws_hashiqube[0].aws_security_group_rule.gcp_hashiqube[0] will be created
  + resource "aws_security_group_rule" "gcp_hashiqube" {
      + cidr_blocks              = (known after apply)
      + description              = "Allow GCP Hashiqube Public IP address"
      + from_port                = 0
      + id                       = (known after apply)
      + protocol                 = "-1"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 65535
      + type                     = "ingress"
    }

  # module.aws_hashiqube[0].aws_security_group_rule.terraform_cloud_api_ip_ranges[0] will be created
  + resource "aws_security_group_rule" "terraform_cloud_api_ip_ranges" {
      + cidr_blocks              = [
          + "75.2.98.97/32",
          + "99.83.150.238/32",
        ]
      + description              = "Allow terraform_cloud_api_ip_ranges"
      + from_port                = 22
      + id                       = (known after apply)
      + protocol                 = "tcp"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 22
      + type                     = "ingress"
    }

  # module.aws_hashiqube[0].aws_security_group_rule.terraform_cloud_notifications_ip_ranges[0] will be created
  + resource "aws_security_group_rule" "terraform_cloud_notifications_ip_ranges" {
      + cidr_blocks              = [
          + "52.86.200.106/32",
          + "52.86.201.227/32",
          + "52.70.186.109/32",
          + "44.236.246.186/32",
          + "54.185.161.84/32",
          + "44.238.78.236/32",
        ]
      + description              = "Allow var.terraform_cloud_notifications_ip_ranges"
      + from_port                = 22
      + id                       = (known after apply)
      + protocol                 = "tcp"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 22
      + type                     = "ingress"
    }

  # module.aws_hashiqube[0].aws_security_group_rule.whitelist_cidr[0] will be created
  + resource "aws_security_group_rule" "whitelist_cidr" {
      + cidr_blocks              = [
          + "20.191.210.171/32",
        ]
      + description              = "Allow Your Whitelist CIDR addresses"
      + from_port                = 0
      + id                       = (known after apply)
      + protocol                 = "-1"
      + security_group_id        = (known after apply)
      + security_group_rule_id   = (known after apply)
      + self                     = false
      + source_security_group_id = (known after apply)
      + to_port                  = 65535
      + type                     = "ingress"
    }

  # module.aws_hashiqube[0].null_resource.debug[0] will be created
  + resource "null_resource" "debug" {
      + id       = (known after apply)
      + triggers = {
          + "timestamp" = (known after apply)
        }
    }

  # module.aws_hashiqube[0].null_resource.hashiqube will be created
  + resource "null_resource" "hashiqube" {
      + id       = (known after apply)
      + triggers = {
          + "azure_hashiqube_ip"   = (known after apply)
          + "deploy_to_aws"        = "true"
          + "deploy_to_azure"      = "true"
          + "deploy_to_gcp"        = "true"
          + "gcp_hashiqube_ip"     = (known after apply)
          + "my_ipaddress"         = "3.235.124.156"
          + "region"               = "ap-southeast-2"
          + "ssh_public_key"       = (sensitive value)
          + "vagrant_provisioners" = "basetools,docker,consul,vault,nomad,boundary,waypoint"
          + "whitelist_cidr"       = "20.191.210.171/32"
        }
    }

  # module.azure_hashiqube[0].azurerm_linux_virtual_machine.hashiqube will be created
  + resource "azurerm_linux_virtual_machine" "hashiqube" {
      + admin_username                  = "ubuntu"
      + allow_extension_operations      = true
      + computer_name                   = (known after apply)
      + custom_data                     = (sensitive value)
      + disable_password_authentication = true
      + extensions_time_budget          = "PT1H30M"
      + id                              = (known after apply)
      + location                        = "australiaeast"
      + max_bid_price                   = -1
      + name                            = "hashiqube"
      + network_interface_ids           = (known after apply)
      + patch_assessment_mode           = "ImageDefault"
      + patch_mode                      = "ImageDefault"
      + platform_fault_domain           = -1
      + priority                        = "Regular"
      + private_ip_address              = (known after apply)
      + private_ip_addresses            = (known after apply)
      + provision_vm_agent              = true
      + public_ip_address               = (known after apply)
      + public_ip_addresses             = (known after apply)
      + resource_group_name             = "hashiqube"
      + size                            = "Standard_DS1_v2"
      + tags                            = {
          + "environment" = "hashiqube"
        }
      + virtual_machine_id              = (known after apply)

      + admin_ssh_key {
          # At least one attribute in this block is (or was) sensitive,
          # so its contents will not be displayed.
        }

      + os_disk {
          + caching                   = "ReadWrite"
          + disk_size_gb              = (known after apply)
          + name                      = (known after apply)
          + storage_account_type      = "Standard_LRS"
          + write_accelerator_enabled = false
        }

      + source_image_reference {
          + offer     = "0001-com-ubuntu-server-focal"
          + publisher = "Canonical"
          + sku       = "20_04-lts-gen2"
          + version   = "latest"
        }
    }

  # module.azure_hashiqube[0].azurerm_network_interface.hashiqube will be created
  + resource "azurerm_network_interface" "hashiqube" {
      + applied_dns_servers           = (known after apply)
      + dns_servers                   = (known after apply)
      + enable_accelerated_networking = false
      + enable_ip_forwarding          = false
      + id                            = (known after apply)
      + internal_dns_name_label       = (known after apply)
      + internal_domain_name_suffix   = (known after apply)
      + location                      = "australiaeast"
      + mac_address                   = (known after apply)
      + name                          = "hashiqube"
      + private_ip_address            = (known after apply)
      + private_ip_addresses          = (known after apply)
      + resource_group_name           = "hashiqube"
      + tags                          = {
          + "environment" = "hashiqube"
        }
      + virtual_machine_id            = (known after apply)

      + ip_configuration {
          + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
          + name                                               = "hashiqube"
          + primary                                            = (known after apply)
          + private_ip_address                                 = (known after apply)
          + private_ip_address_allocation                      = "Dynamic"
          + private_ip_address_version                         = "IPv4"
          + public_ip_address_id                               = (known after apply)
          + subnet_id                                          = (known after apply)
        }
    }

  # module.azure_hashiqube[0].azurerm_network_security_group.aws_hashiqube_ip[0] will be created
  + resource "azurerm_network_security_group" "aws_hashiqube_ip" {
      + id                  = (known after apply)
      + location            = "australiaeast"
      + name                = "aws_hashiqube_ip"
      + resource_group_name = "hashiqube"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = ""
              + destination_address_prefixes               = (known after apply)
              + destination_application_security_group_ids = []
              + destination_port_range                     = "*"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "aws_hashiqube_ip"
              + priority                                   = 1003
              + protocol                                   = "Tcp"
              + source_address_prefix                      = ""
              + source_address_prefixes                    = (known after apply)
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
      + tags                = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure_hashiqube[0].azurerm_network_security_group.azure_hashiqube_ip[0] will be created
  + resource "azurerm_network_security_group" "azure_hashiqube_ip" {
      + id                  = (known after apply)
      + location            = "australiaeast"
      + name                = "azure_hashiqube_ip"
      + resource_group_name = "hashiqube"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = ""
              + destination_address_prefixes               = (known after apply)
              + destination_application_security_group_ids = []
              + destination_port_range                     = "*"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "azure_hashiqube_ip"
              + priority                                   = 1002
              + protocol                                   = "Tcp"
              + source_address_prefix                      = ""
              + source_address_prefixes                    = (known after apply)
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
      + tags                = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure_hashiqube[0].azurerm_network_security_group.gcp_hashiqube_ip[0] will be created
  + resource "azurerm_network_security_group" "gcp_hashiqube_ip" {
      + id                  = (known after apply)
      + location            = "australiaeast"
      + name                = "gcp_hashiqube_ip"
      + resource_group_name = "hashiqube"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = ""
              + destination_address_prefixes               = (known after apply)
              + destination_application_security_group_ids = []
              + destination_port_range                     = "*"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "gcp_hashiqube_ip"
              + priority                                   = 1004
              + protocol                                   = "Tcp"
              + source_address_prefix                      = ""
              + source_address_prefixes                    = (known after apply)
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
      + tags                = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure_hashiqube[0].azurerm_network_security_group.my_ipaddress will be created
  + resource "azurerm_network_security_group" "my_ipaddress" {
      + id                  = (known after apply)
      + location            = "australiaeast"
      + name                = "hashiqube"
      + resource_group_name = "hashiqube"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = ""
              + destination_address_prefixes               = (known after apply)
              + destination_application_security_group_ids = []
              + destination_port_range                     = "*"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "myipaddress"
              + priority                                   = 1001
              + protocol                                   = "Tcp"
              + source_address_prefix                      = ""
              + source_address_prefixes                    = [
                  + "3.235.124.156/32",
                ]
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
      + tags                = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure_hashiqube[0].azurerm_network_security_group.terraform_cloud_api_ip_ranges[0] will be created
  + resource "azurerm_network_security_group" "terraform_cloud_api_ip_ranges" {
      + id                  = (known after apply)
      + location            = "australiaeast"
      + name                = "terraform_cloud_api_ip_ranges"
      + resource_group_name = "hashiqube"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = ""
              + destination_address_prefixes               = (known after apply)
              + destination_application_security_group_ids = []
              + destination_port_range                     = "22"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "terraform_cloud_api_ip_ranges"
              + priority                                   = 1006
              + protocol                                   = "Tcp"
              + source_address_prefix                      = ""
              + source_address_prefixes                    = [
                  + "75.2.98.97/32",
                  + "99.83.150.238/32",
                ]
              + source_application_security_group_ids      = []
              + source_port_range                          = "22"
              + source_port_ranges                         = []
            },
        ]
      + tags                = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure_hashiqube[0].azurerm_network_security_group.terraform_cloud_notifications_ip_ranges[0] will be created
  + resource "azurerm_network_security_group" "terraform_cloud_notifications_ip_ranges" {
      + id                  = (known after apply)
      + location            = "australiaeast"
      + name                = "terraform_cloud_notifications_ip_ranges"
      + resource_group_name = "hashiqube"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = ""
              + destination_address_prefixes               = (known after apply)
              + destination_application_security_group_ids = []
              + destination_port_range                     = "22"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "terraform_cloud_notifications_ip_ranges"
              + priority                                   = 1007
              + protocol                                   = "Tcp"
              + source_address_prefix                      = ""
              + source_address_prefixes                    = [
                  + "44.236.246.186/32",
                  + "44.238.78.236/32",
                  + "52.70.186.109/32",
                  + "52.86.200.106/32",
                  + "52.86.201.227/32",
                  + "54.185.161.84/32",
                ]
              + source_application_security_group_ids      = []
              + source_port_range                          = "22"
              + source_port_ranges                         = []
            },
        ]
      + tags                = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure_hashiqube[0].azurerm_network_security_group.whitelist_cidr[0] will be created
  + resource "azurerm_network_security_group" "whitelist_cidr" {
      + id                  = (known after apply)
      + location            = "australiaeast"
      + name                = "whitelist_cidr"
      + resource_group_name = "hashiqube"
      + security_rule       = [
          + {
              + access                                     = "Allow"
              + description                                = ""
              + destination_address_prefix                 = ""
              + destination_address_prefixes               = (known after apply)
              + destination_application_security_group_ids = []
              + destination_port_range                     = "*"
              + destination_port_ranges                    = []
              + direction                                  = "Inbound"
              + name                                       = "whitelist_cidr"
              + priority                                   = 1005
              + protocol                                   = "Tcp"
              + source_address_prefix                      = ""
              + source_address_prefixes                    = [
                  + "20.191.210.171/32",
                ]
              + source_application_security_group_ids      = []
              + source_port_range                          = "*"
              + source_port_ranges                         = []
            },
        ]
      + tags                = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure_hashiqube[0].azurerm_public_ip.hashiqube will be created
  + resource "azurerm_public_ip" "hashiqube" {
      + allocation_method       = "Static"
      + ddos_protection_mode    = "VirtualNetworkInherited"
      + fqdn                    = (known after apply)
      + id                      = (known after apply)
      + idle_timeout_in_minutes = 4
      + ip_address              = (known after apply)
      + ip_version              = "IPv4"
      + location                = "australiaeast"
      + name                    = "hashiqube"
      + resource_group_name     = "hashiqube"
      + sku                     = "Basic"
      + sku_tier                = "Regional"
      + tags                    = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure_hashiqube[0].azurerm_resource_group.hashiqube will be created
  + resource "azurerm_resource_group" "hashiqube" {
      + id       = (known after apply)
      + location = "australiaeast"
      + name     = "hashiqube"
      + tags     = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure_hashiqube[0].azurerm_subnet.hashiqube will be created
  + resource "azurerm_subnet" "hashiqube" {
      + address_prefixes                               = [
          + "10.0.1.0/24",
        ]
      + enforce_private_link_endpoint_network_policies = (known after apply)
      + enforce_private_link_service_network_policies  = (known after apply)
      + id                                             = (known after apply)
      + name                                           = "hashiqube"
      + private_endpoint_network_policies_enabled      = (known after apply)
      + private_link_service_network_policies_enabled  = (known after apply)
      + resource_group_name                            = "hashiqube"
      + virtual_network_name                           = "hashiqube"
    }

  # module.azure_hashiqube[0].azurerm_virtual_network.hashiqube will be created
  + resource "azurerm_virtual_network" "hashiqube" {
      + address_space       = [
          + "10.0.0.0/16",
        ]
      + dns_servers         = (known after apply)
      + guid                = (known after apply)
      + id                  = (known after apply)
      + location            = "australiaeast"
      + name                = "hashiqube"
      + resource_group_name = "hashiqube"
      + subnet              = (known after apply)
      + tags                = {
          + "environment" = "hashiqube"
        }
    }

  # module.azure_hashiqube[0].null_resource.debug[0] will be created
  + resource "null_resource" "debug" {
      + id       = (known after apply)
      + triggers = {
          + "timestamp" = (known after apply)
        }
    }

  # module.azure_hashiqube[0].null_resource.hashiqube will be created
  + resource "null_resource" "hashiqube" {
      + id       = (known after apply)
      + triggers = {
          + "aws_hashiqube_ip"     = (known after apply)
          + "azure_instance_type"  = "Standard_DS1_v2"
          + "azure_region"         = "Australia East"
          + "deploy_to_aws"        = "true"
          + "deploy_to_azure"      = "true"
          + "deploy_to_gcp"        = "true"
          + "gcp_hashiqube_ip"     = (known after apply)
          + "my_ipaddress"         = "3.235.124.156"
          + "ssh_public_key"       = (sensitive value)
          + "vagrant_provisioners" = "basetools,docker,consul,vault,nomad,boundary,waypoint"
          + "whitelist_cidr"       = "20.191.210.171/32"
        }
    }

  # module.gcp_hashiqube[0].google_compute_address.hashiqube will be created
  + resource "google_compute_address" "hashiqube" {
      + address            = (known after apply)
      + address_type       = "EXTERNAL"
      + creation_timestamp = (known after apply)
      + id                 = (known after apply)
      + name               = "hashiqube"
      + network_tier       = (known after apply)
      + prefix_length      = (known after apply)
      + project            = (known after apply)
      + purpose            = (known after apply)
      + region             = (known after apply)
      + self_link          = (known after apply)
      + subnetwork         = (known after apply)
      + users              = (known after apply)
    }

  # module.gcp_hashiqube[0].google_compute_firewall.aws_hashiqube_ip[0] will be created
  + resource "google_compute_firewall" "aws_hashiqube_ip" {
      + creation_timestamp = (known after apply)
      + destination_ranges = (known after apply)
      + direction          = (known after apply)
      + enable_logging     = (known after apply)
      + id                 = (known after apply)
      + name               = "aws-hashiqube-ip"
      + network            = "default"
      + priority           = 1000
      + project            = (sensitive value)
      + self_link          = (known after apply)
      + source_ranges      = (known after apply)

      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "tcp"
        }
      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "udp"
        }
    }

  # module.gcp_hashiqube[0].google_compute_firewall.azure_hashiqube_ip[0] will be created
  + resource "google_compute_firewall" "azure_hashiqube_ip" {
      + creation_timestamp = (known after apply)
      + destination_ranges = (known after apply)
      + direction          = (known after apply)
      + enable_logging     = (known after apply)
      + id                 = (known after apply)
      + name               = "azure-hashiqube-ip"
      + network            = "default"
      + priority           = 1000
      + project            = (sensitive value)
      + self_link          = (known after apply)
      + source_ranges      = (known after apply)

      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "tcp"
        }
      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "udp"
        }
    }

  # module.gcp_hashiqube[0].google_compute_firewall.gcp_hashiqube_ip[0] will be created
  + resource "google_compute_firewall" "gcp_hashiqube_ip" {
      + creation_timestamp = (known after apply)
      + destination_ranges = (known after apply)
      + direction          = (known after apply)
      + enable_logging     = (known after apply)
      + id                 = (known after apply)
      + name               = "gcp-hashiqube-ip"
      + network            = "default"
      + priority           = 1000
      + project            = (sensitive value)
      + self_link          = (known after apply)
      + source_ranges      = (known after apply)

      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "tcp"
        }
      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "udp"
        }
    }

  # module.gcp_hashiqube[0].google_compute_firewall.my_ipaddress will be created
  + resource "google_compute_firewall" "my_ipaddress" {
      + creation_timestamp = (known after apply)
      + destination_ranges = (known after apply)
      + direction          = (known after apply)
      + enable_logging     = (known after apply)
      + id                 = (known after apply)
      + name               = "hashiqube-my-ipaddress"
      + network            = "default"
      + priority           = 1000
      + project            = (sensitive value)
      + self_link          = (known after apply)
      + source_ranges      = [
          + "3.235.124.156/32",
        ]

      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "tcp"
        }
      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "udp"
        }
    }

  # module.gcp_hashiqube[0].google_compute_firewall.terraform_cloud_api_ip_ranges[0] will be created
  + resource "google_compute_firewall" "terraform_cloud_api_ip_ranges" {
      + creation_timestamp = (known after apply)
      + destination_ranges = (known after apply)
      + direction          = (known after apply)
      + enable_logging     = (known after apply)
      + id                 = (known after apply)
      + name               = "terraform-cloud-api-ip-ranges"
      + network            = "default"
      + priority           = 1000
      + project            = (sensitive value)
      + self_link          = (known after apply)
      + source_ranges      = [
          + "75.2.98.97/32",
          + "99.83.150.238/32",
        ]

      + allow {
          + ports    = [
              + "22",
            ]
          + protocol = "tcp"
        }
    }

  # module.gcp_hashiqube[0].google_compute_firewall.terraform_cloud_notifications_ip_ranges[0] will be created
  + resource "google_compute_firewall" "terraform_cloud_notifications_ip_ranges" {
      + creation_timestamp = (known after apply)
      + destination_ranges = (known after apply)
      + direction          = (known after apply)
      + enable_logging     = (known after apply)
      + id                 = (known after apply)
      + name               = "terraform-cloud-notifications-ip-ranges"
      + network            = "default"
      + priority           = 1000
      + project            = (sensitive value)
      + self_link          = (known after apply)
      + source_ranges      = [
          + "44.236.246.186/32",
          + "44.238.78.236/32",
          + "52.70.186.109/32",
          + "52.86.200.106/32",
          + "52.86.201.227/32",
          + "54.185.161.84/32",
        ]

      + allow {
          + ports    = [
              + "22",
            ]
          + protocol = "tcp"
        }
    }

  # module.gcp_hashiqube[0].google_compute_firewall.whitelist_cidr[0] will be created
  + resource "google_compute_firewall" "whitelist_cidr" {
      + creation_timestamp = (known after apply)
      + destination_ranges = (known after apply)
      + direction          = (known after apply)
      + enable_logging     = (known after apply)
      + id                 = (known after apply)
      + name               = "whitelist-cidr"
      + network            = "default"
      + priority           = 1000
      + project            = (sensitive value)
      + self_link          = (known after apply)
      + source_ranges      = [
          + "20.191.210.171/32",
        ]

      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "tcp"
        }
      + allow {
          + ports    = [
              + "0-65535",
            ]
          + protocol = "udp"
        }
    }

  # module.gcp_hashiqube[0].google_compute_instance_template.hashiqube will be created
  + resource "google_compute_instance_template" "hashiqube" {
      + can_ip_forward          = false
      + description             = "hashiqube"
      + id                      = (known after apply)
      + instance_description    = "hashiqube"
      + machine_type            = "n1-standard-1"
      + metadata                = {
          + "ssh-keys" = (sensitive value)
        }
      + metadata_fingerprint    = (known after apply)
      + metadata_startup_script = (known after apply)
      + name                    = (known after apply)
      + name_prefix             = "hashiqube"
      + project                 = (known after apply)
      + region                  = (known after apply)
      + self_link               = (known after apply)
      + self_link_unique        = (known after apply)
      + tags                    = [
          + "hashiqube",
        ]
      + tags_fingerprint        = (known after apply)

      + disk {
          + auto_delete      = true
          + boot             = true
          + device_name      = (known after apply)
          + disk_size_gb     = 16
          + disk_type        = "pd-standard"
          + interface        = (known after apply)
          + mode             = (known after apply)
          + provisioned_iops = (known after apply)
          + source_image     = "ubuntu-os-cloud/ubuntu-2004-lts"
          + type             = (known after apply)
        }

      + network_interface {
          + ipv6_access_type   = (known after apply)
          + name               = (known after apply)
          + network            = (known after apply)
          + stack_type         = (known after apply)
          + subnetwork         = "https://www.googleapis.com/compute/v1/projects/riaan-nolan-368709/regions/australia-southeast1/subnetworks/default"
          + subnetwork_project = (known after apply)

          + access_config {
              + nat_ip                 = (known after apply)
              + network_tier           = (known after apply)
              + public_ptr_domain_name = (known after apply)
            }
        }

      + scheduling {
          + automatic_restart   = true
          + on_host_maintenance = "MIGRATE"
          + preemptible         = false
          + provisioning_model  = (known after apply)
        }

      + service_account {
          + email  = (known after apply)
          + scopes = [
              + "https://www.googleapis.com/auth/compute.readonly",
              + "https://www.googleapis.com/auth/devstorage.read_write",
              + "https://www.googleapis.com/auth/userinfo.email",
            ]
        }
    }

  # module.gcp_hashiqube[0].google_compute_region_instance_group_manager.hashiqube will be created
  + resource "google_compute_region_instance_group_manager" "hashiqube" {
      + base_instance_name               = "hashiqube"
      + distribution_policy_target_shape = (known after apply)
      + distribution_policy_zones        = [
          + "australia-southeast1-a",
          + "australia-southeast1-b",
          + "australia-southeast1-c",
        ]
      + fingerprint                      = (known after apply)
      + id                               = (known after apply)
      + instance_group                   = (known after apply)
      + list_managed_instances_results   = "PAGELESS"
      + name                             = "hashiqube"
      + project                          = (known after apply)
      + region                           = "australia-southeast1"
      + self_link                        = (known after apply)
      + status                           = (known after apply)
      + target_size                      = 1
      + wait_for_instances               = false
      + wait_for_instances_status        = "STABLE"

      + update_policy {
          + max_surge_fixed       = 3
          + max_unavailable_fixed = 0
          + minimal_action        = "REPLACE"
          + type                  = "PROACTIVE"
        }

      + version {
          + instance_template = (known after apply)
          + name              = "hashiqube"
        }
    }

  # module.gcp_hashiqube[0].google_project_iam_member.hashiqube will be created
  + resource "google_project_iam_member" "hashiqube" {
      + etag    = (known after apply)
      + id      = (known after apply)
      + member  = (known after apply)
      + project = (sensitive value)
      + role    = "roles/compute.networkViewer"
    }

  # module.gcp_hashiqube[0].google_service_account.hashiqube will be created
  + resource "google_service_account" "hashiqube" {
      + account_id   = "sa-consul-compute-prod"
      + disabled     = false
      + display_name = "hashiqube"
      + email        = (known after apply)
      + id           = (known after apply)
      + member       = (known after apply)
      + name         = (known after apply)
      + project      = (sensitive value)
      + unique_id    = (known after apply)
    }

  # module.gcp_hashiqube[0].null_resource.debug[0] will be created
  + resource "null_resource" "debug" {
      + id       = (known after apply)
      + triggers = {
          + "timestamp" = (known after apply)
        }
    }

  # module.gcp_hashiqube[0].null_resource.hashiqube will be created
  + resource "null_resource" "hashiqube" {
      + id       = (known after apply)
      + triggers = {
          + "aws_hashiqube_ip"     = (known after apply)
          + "azure_hashiqube_ip"   = (known after apply)
          + "deploy_to_aws"        = "true"
          + "deploy_to_azure"      = "true"
          + "deploy_to_gcp"        = "true"
          + "gcp_credentials"      = "~/.gcp/credentials.json"
          + "gcp_project"          = (sensitive value)
          + "my_ipaddress"         = "3.235.124.156"
          + "ssh_public_key"       = (sensitive value)
          + "vagrant_provisioners" = "basetools,docker,consul,vault,nomad,boundary,waypoint"
          + "whitelist_cidr"       = "20.191.210.171/32"
        }
    }

Plan: 46 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + aaa_welcome                             = <<-EOT
        Your HashiQube instance is busy launching, usually this takes ~5 minutes.
        Below are some links to open in your browser, and commands you can copy and paste in a terminal to login via SSH into your HashiQube instance.
        Thank you for using this module, you are most welcome to fork this repository to make it your own.
        ** DO NOT USE THIS IN PRODUCTION **
    EOT
  + aab_instructions                        = <<-EOT
        Use the Hashiqube SSH output below to login to your instance
        To get Vault Shamir keys and Root token do "sudo cat /etc/vault/init.file"
    EOT
  + aws_hashiqube_boundary                  = (known after apply)
  + aws_hashiqube_consul                    = (known after apply)
  + aws_hashiqube_fabio_lb                  = (known after apply)
  + aws_hashiqube_fabio_ui                  = (known after apply)
  + aws_hashiqube_ip                        = (known after apply)
  + aws_hashiqube_nomad                     = (known after apply)
  + aws_hashiqube_ssh                       = (known after apply)
  + aws_hashiqube_traefik_lb                = (known after apply)
  + aws_hashiqube_traefik_ui                = (known after apply)
  + aws_hashiqube_vault                     = (known after apply)
  + aws_hashiqube_waypoint                  = (known after apply)
  + azure_hashiqube_boundary                = (known after apply)
  + azure_hashiqube_consul                  = (known after apply)
  + azure_hashiqube_fabio_lb                = (known after apply)
  + azure_hashiqube_fabio_ui                = (known after apply)
  + azure_hashiqube_ip                      = (known after apply)
  + azure_hashiqube_nomad                   = (known after apply)
  + azure_hashiqube_ssh                     = (known after apply)
  + azure_hashiqube_traefik_lb              = (known after apply)
  + azure_hashiqube_traefik_ui              = (known after apply)
  + azure_hashiqube_vault                   = (known after apply)
  + azure_hashiqube_waypoint                = (known after apply)
  + gcp_hashiqube_boundary                  = (known after apply)
  + gcp_hashiqube_consul                    = (known after apply)
  + gcp_hashiqube_fabio_lb                  = (known after apply)
  + gcp_hashiqube_fabio_ui                  = (known after apply)
  + gcp_hashiqube_ip                        = (known after apply)
  + gcp_hashiqube_nomad                     = (known after apply)
  + gcp_hashiqube_ssh                       = (known after apply)
  + gcp_hashiqube_traefik_lb                = (known after apply)
  + gcp_hashiqube_traefik_ui                = (known after apply)
  + gcp_hashiqube_vault                     = (known after apply)
  + gcp_hashiqube_waypoint                  = (known after apply)
  + terraform_cloud_api_ip_ranges           = [
      + "75.2.98.97/32",
      + "99.83.150.238/32",
    ]
  + terraform_cloud_notifications_ip_ranges = [
      + "52.86.200.106/32",
      + "52.86.201.227/32",
      + "52.70.186.109/32",
      + "44.236.246.186/32",
      + "54.185.161.84/32",
      + "44.238.78.236/32",
    ]
  + terraform_cloud_sentinel_ip_ranges      = [
      + "52.86.200.106/32",
      + "52.86.201.227/32",
      + "52.70.186.109/32",
      + "44.236.246.186/32",
      + "54.185.161.84/32",
      + "44.238.78.236/32",
    ]
  + terraform_cloud_vcs_ip_ranges           = [
      + "52.86.200.106/32",
      + "52.86.201.227/32",
      + "52.70.186.109/32",
      + "44.236.246.186/32",
      + "54.185.161.84/32",
      + "44.238.78.236/32",
    ]
  + your_ipaddress                          = "3.235.124.156"

------------------------------------------------------------------------

Cost Estimation:

Resources: 2 of 14 estimated
           $93.888/mo +$93.888

------------------------------------------------------------------------

Organization Policy Check:

================ Results for policy set: <empty policy set name> ===============

Sentinel Result: true

This result means that all Sentinel policies passed and the protected
behavior is allowed.

1 policies evaluated.

## Policy 1: limit-costs (advisory)

Result: false

Description:
  This policy uses the Sentinel tfrun import to restrict the  proposed monthly cost that would be incurred if the current  plan were applied, using different limits for different  workspaces based on their names.

Print messages:

Proposed monthly cost 93.888 of workspace terraform-hashicorp-hashiqube is over the limit: $ 50

./limit-costs.sentinel:70:1 - Rule "main"
  Description:
    Main rule

  Value:
    false


[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Get ENV vars from Vault)
[Pipeline] withVault
Retrieving secret: kv2/secret/another_test
Retrieving secret: kv1/secret/testing/value_one
Retrieving secret: kv1/secret/testing/value_two
[Pipeline] {
[Pipeline] sh
+ echo ****
****
[Pipeline] sh
+ echo ****
****
[Pipeline] sh
+ echo ****
****
[Pipeline] }
[Pipeline] // withVault
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Echo some ENV vars)
[Pipeline] withCredentials
Masking supported pattern matches of $VAULT_ADDR or $VAULT_TOKEN or $VAULT_NAMESPACE
[Pipeline] {
[Pipeline] sh
+ echo TOKEN=****
TOKEN=****
[Pipeline] sh
+ echo ADDR=****
ADDR=****
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] sh
+ + env
sort
[Pipeline] echo
ARCH=arm64
BUILD_DISPLAY_NAME=#109
BUILD_ID=109
BUILD_NUMBER=109
BUILD_TAG=jenkins-test-109
BUILD_URL=http://localhost:8088/job/test/109/
CI=true
COPY_REFERENCE_FILE_LOG=/var/jenkins_home/copy_reference_file.log
EXECUTOR_NUMBER=1
HOME=/var/jenkins_home
HOSTNAME=921e86e94bf7
HUDSON_COOKIE=15cfba41-7d81-4d48-97f9-60d42a5c58e7
HUDSON_HOME=/var/jenkins_home
HUDSON_SERVER_COOKIE=79aead07081a8d8a
HUDSON_URL=http://localhost:8088/
JAVA_HOME=/opt/java/openjdk
JENKINS_HOME=/var/jenkins_home
JENKINS_INCREMENTALS_REPO_MIRROR=https://repo.jenkins-ci.org/incrementals
JENKINS_NODE_COOKIE=0bb2b8ee-e9b8-4ce0-b282-2fecbd036465
JENKINS_OPTS=--httpPort=8088
JENKINS_SERVER_COOKIE=durable-7190c2fadc48570bd1d6b9ff3df70884d6b72f619c1a447143f9aae059f70e9f
JENKINS_SLAVE_AGENT_PORT=50000
JENKINS_UC=https://updates.jenkins.io
JENKINS_UC_EXPERIMENTAL=https://updates.jenkins.io/experimental
JENKINS_URL=http://localhost:8088/
JENKINS_VERSION=2.414.1
JOB_BASE_NAME=test
JOB_DISPLAY_URL=http://localhost:8088/job/test/display/redirect
JOB_NAME=test
JOB_URL=http://localhost:8088/job/test/
LANG=C.UTF-8
NODE_LABELS=built-in
NODE_NAME=built-in
PATH=/opt/java/openjdk/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/var/jenkins_home/workspace/test/bin
PWD=/var/jenkins_home/workspace/test
REF=/usr/share/jenkins/ref
RUN_ARTIFACTS_DISPLAY_URL=http://localhost:8088/job/test/109/display/redirect?page=artifacts
RUN_CHANGES_DISPLAY_URL=http://localhost:8088/job/test/109/display/redirect?page=changes
RUN_DISPLAY_URL=http://localhost:8088/job/test/109/display/redirect
RUN_TESTS_DISPLAY_URL=http://localhost:8088/job/test/109/display/redirect?page=tests
SHLVL=0
STAGE_NAME=Echo some ENV vars
TF_CLI_ARGS=-no-color
WORKSPACE=/var/jenkins_home/workspace/test
WORKSPACE_TMP=/var/jenkins_home/workspace/test@tmp

[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
```

You can click on that job and view the console, for more output, you should see your secrets are totally hidden and provided by Vault.
![Jenkins](images/jenkins_job_vault-jenkins_build_console.png?raw=true "Jenkins")

## The Code

[filename](jenkins.sh ':include :type=code')