# Gitlab
https://docs.gitlab.com/omnibus/docker/ <br />
https://gitlab.com/ <br />

![Gitlab Logo](images/gitlab-logo.png?raw=true "Gitlab Logo")

GitLab is a complete DevOps platform
With GitLab, you get a complete CI/CD toolchain in a single application. One interface. One conversation. One permission model. Thousands of features. You'll be amazed at everything GitLab can do today. And we're just getting started.

`vagrant up --provision-with basetools,docker,docsify,minikube,gitlab`
```
Bringing machine 'user.local.dev' up with 'virtualbox' provider...
==> user.local.dev: Checking if box 'ubuntu/bionic64' version '20191218.0.0' is up to date...
==> user.local.dev: A newer version of the box 'ubuntu/bionic64' for provider 'virtualbox' is
==> user.local.dev: available! You currently have version '20191218.0.0'. The latest is version
==> user.local.dev: '20200320.0.0'. Run `vagrant box update` to update.
==> user.local.dev: [vagrant-hostsupdater] Checking for host entries
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: Running provisioner: gitlab (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200322-5726-1n59yfc.sh
    user.local.dev: gitlab
    user.local.dev: gitlab
    user.local.dev: WARNING! This will remove:
    user.local.dev:   - all stopped containers
    user.local.dev:   - all networks not used by at least one container
    user.local.dev:   - all images without at least one container associated to them
    user.local.dev:   - all build cache
    user.local.dev:
    user.local.dev: Are you sure you want to continue? [y/N]
    user.local.dev: Deleted Images:
    user.local.dev: untagged: gitlab/gitlab-ce:latest
    user.local.dev: untagged: gitlab/gitlab-ce@sha256:3afa71e1190aa569dcd25393dec9f0c7bb5e6f3c77a7cde4e3edcd3a9d2945f9
    user.local.dev: deleted: sha256:5f5beb0b3864275ccc97278ea52589e685219e2a3e04be2d8e7365456d9c5378
    user.local.dev: deleted: sha256:8f0e5f4210d74eace9389a407bbb381792288b655629c1a4b20810e607361824
    user.local.dev: deleted: sha256:a5194ed124401b214491961ef3605c45c67b90ec015519feb0dbe0890a7f4021
    user.local.dev: deleted: sha256:290dfa15c40d4a67abacb026322857f456b5922215e9f66d474efbc815ded598
    user.local.dev: deleted: sha256:c0d7a7fb3f928cd0b06ac4ae562a546882f088fe3a5d2b753063027ed46a551c
    user.local.dev: deleted: sha256:91e50094808f0ea9f6410e5b6be516a53128f8d26af0891edef213909465b583
    user.local.dev: deleted: sha256:7cce31f9e80bd3527bbd49ef6ebc860bc87ec6ac141a743c36fbc36e788683c9
    user.local.dev: deleted: sha256:b4d3af941054c99b15c27b809f4115ddc94c307aa97705c53c52b1b687298ba5
    user.local.dev: deleted: sha256:36fb0d2dd04845e4d517cdb206bc16303172273150b8a74387ebc24157fc5bc6
    user.local.dev: deleted: sha256:7c66d02ec02b23556302d9826e1966a6c94b775ec87bc5779acf26b0365ed2fb
    user.local.dev: deleted: sha256:9e6f810a2aabaa90d8e79f52847c74617a94e78fe223f4f067d84a6bd63b9393
    user.local.dev: Total reclaimed space: 1.891GB
    user.local.dev: WARNING! This will remove:
    user.local.dev:   - all stopped containers
    user.local.dev:   - all networks not used by at least one container
    user.local.dev:   - all volumes not used by at least one container
    user.local.dev:   - all dangling images
    user.local.dev:   - all dangling build cache
    user.local.dev:
    user.local.dev: Are you sure you want to continue? [y/N]
    user.local.dev: Deleted Volumes:
    user.local.dev: 6188ee4ed6a6dd7f03f5628a4d95c184b539ba32226dea1dc049474c7140bf4f
    user.local.dev: 75f665a31e4f428da8cae191f6de747ff55d63f490bc4d297c1df2640ed898a5
    user.local.dev: db5f7c7082c58c7ced37a686942b0b1cd351f43dfad2e3d0d4d1added34bb459
    user.local.dev: Total reclaimed space: 97.57MB
    user.local.dev: Unable to find image 'gitlab/gitlab-ce:latest' locally
    user.local.dev: latest: Pulling from gitlab/gitlab-ce
    user.local.dev: fe703b657a32: Pulling fs layer
    user.local.dev: f9df1fafd224: Pulling fs layer
    user.local.dev: a645a4b887f9: Pulling fs layer
    user.local.dev: 57db7fe0b522: Pulling fs layer
    user.local.dev: 98460accf7eb: Pulling fs layer
    user.local.dev: aab06448ee0e: Pulling fs layer
    user.local.dev: 62d273ca4921: Pulling fs layer
    user.local.dev: 44e7cbf3a283: Pulling fs layer
    user.local.dev: 6b9a835e3a50: Pulling fs layer
    user.local.dev: 47effe7a708f: Pulling fs layer
    user.local.dev: aab06448ee0e: Waiting
    user.local.dev: 62d273ca4921: Waiting
    user.local.dev: 44e7cbf3a283: Waiting
    user.local.dev: 6b9a835e3a50: Waiting
    user.local.dev: 47effe7a708f: Waiting
    user.local.dev: 57db7fe0b522: Waiting
    user.local.dev: 98460accf7eb: Waiting
    user.local.dev: f9df1fafd224: Download complete
    user.local.dev: a645a4b887f9: Verifying Checksum
    user.local.dev: a645a4b887f9: Download complete
    user.local.dev: 57db7fe0b522: Verifying Checksum
    user.local.dev: 57db7fe0b522: Download complete
    user.local.dev: aab06448ee0e:
    user.local.dev: Verifying Checksum
    user.local.dev: aab06448ee0e:
    user.local.dev: Download complete
    user.local.dev: 62d273ca4921: Verifying Checksum
    user.local.dev: 62d273ca4921:
    user.local.dev: Download complete
    user.local.dev: 44e7cbf3a283: Verifying Checksum
    user.local.dev: 44e7cbf3a283: Download complete
    user.local.dev: 6b9a835e3a50:
    user.local.dev: Verifying Checksum
    user.local.dev: 6b9a835e3a50:
    user.local.dev: Download complete
    user.local.dev: 98460accf7eb:
    user.local.dev: Verifying Checksum
    user.local.dev: 98460accf7eb:
    user.local.dev: Download complete
    user.local.dev: fe703b657a32: Download complete
    user.local.dev: fe703b657a32: Pull complete
    user.local.dev: f9df1fafd224: Pull complete
    user.local.dev: a645a4b887f9: Pull complete
    user.local.dev: 57db7fe0b522: Pull complete
    user.local.dev: 98460accf7eb: Pull complete
    user.local.dev: aab06448ee0e: Pull complete
    user.local.dev: 62d273ca4921: Pull complete
    user.local.dev: 44e7cbf3a283: Pull complete
    user.local.dev: 6b9a835e3a50: Pull complete
    user.local.dev: 47effe7a708f: Verifying Checksum
    user.local.dev: 47effe7a708f: Download complete
    user.local.dev: 47effe7a708f:
    user.local.dev: Pull complete
    user.local.dev: Digest: sha256:3afa71e1190aa569dcd25393dec9f0c7bb5e6f3c77a7cde4e3edcd3a9d2945f9
    user.local.dev: Status: Downloaded newer image for gitlab/gitlab-ce:latest
    user.local.dev: 6cbb034b25fcd584ec3422269404501ec9ac39f6e8ad6cfa4fe8407a1daf65b6
    user.local.dev: /opt/gitlab/embedded/bin/runsvdir-start: line 24: ulimit: pending signals: cannot modify limit: Operation not permitted
    user.local.dev: /opt/gitlab/embedded/bin/runsvdir-start: line 37: /proc/sys/fs/file-max: Read-only file system
    user.local.dev: Thank you for using GitLab Docker Image!
    user.local.dev: Current version: gitlab-ce=12.8.7-ce.0
    user.local.dev:
    user.local.dev: Configure GitLab for your system by editing /etc/gitlab/gitlab.rb file
    user.local.dev: And restart this container to reload settings.
    user.local.dev: To do it use docker exec:
    user.local.dev:
    user.local.dev:   docker exec -it gitlab vim /etc/gitlab/gitlab.rb
    user.local.dev:   docker restart gitlab
    user.local.dev:
    user.local.dev: For a comprehensive list of configuration options please see the Omnibus GitLab readme
    user.local.dev: https://gitlab.com/gitlab-org/omnibus-gitlab/blob/master/README.md
    user.local.dev:
    user.local.dev: If this container fails to start due to permission problems try to fix it by executing:
    user.local.dev:
    user.local.dev:   docker exec -it gitlab update-permissions
    user.local.dev:   docker restart gitlab
    user.local.dev:
    user.local.dev: Cleaning stale PIDs & sockets
    user.local.dev: Installing gitlab.rb config...
    user.local.dev: Generating ssh_host_rsa_key...
    user.local.dev: Generating public/private rsa key pair.
    user.local.dev: Your identification has been saved in /etc/gitlab/ssh_host_rsa_key.
    user.local.dev: Your public key has been saved in /etc/gitlab/ssh_host_rsa_key.pub.
    user.local.dev: The key fingerprint is:
    user.local.dev: SHA256:lSVjzGEn3J4JTt44PVGhtVKDVU9KKwpF+Y1XkeCjTvM root@10.9.99.10
    user.local.dev: The key's randomart image is:
    user.local.dev: +---[RSA 2048]----+
    user.local.dev: |         =X+o=X+=|
    user.local.dev: |         +BB== Bo|
    user.local.dev: |        .+oB+O+..|
    user.local.dev: |         o=.@o+  |
    user.local.dev: |        S .= o   |
    user.local.dev: |          o o    |
    user.local.dev: |           . E   |
    user.local.dev: |                 |
    user.local.dev: |                 |
    user.local.dev: +----[SHA256]-----+
    user.local.dev: Generating ssh_host_ecdsa_key...
    user.local.dev: Generating public/private ecdsa key pair.
    user.local.dev: Your identification has been saved in /etc/gitlab/ssh_host_ecdsa_key.
    user.local.dev: Your public key has been saved in /etc/gitlab/ssh_host_ecdsa_key.pub.
    user.local.dev: The key fingerprint is:
    ..
    user.local.dev:               Administrator account created:
    user.local.dev: ++++ To use Gitlab please open in your browser
    user.local.dev: ++++ http://10.9.99.10:5580
```
When you visit http://10.9.99.10:5580 you will be asked to create a new password
![Gitlab](images/gitlab-create-root-password.png?raw=true "Gitlab")

Now please login with username __root__ and the password you set in the previous step
![Gitlab](images/gitlab-login-root-password.png?raw=true "Gitlab")

Now you should be logged into Gitlab
![Gitlab](images/gitlab-first-login.png?raw=true "Gitlab")

## You are here

Now let's create our first project in Gitlab
Click on Create Project -> 
![Gitlab Create Project](images/gitlab-create-project.png?raw=true "Gitlab Create Projetc")

## Runners
https://docs.gitlab.com/runner/register/index.html#docker

Let's register a Gitlab runner for My awesome project, please navigate to Settings -> CI/CD -> Runners and click expand

http://localhost:5580/root/my-awesome-project/-/settings/ci_cd

![Gitlab Create Project Runner](images/gitlab-my-awesome-project-cicd-runners.png?raw=true "Gitlab Create Project Runner")

Now grab your Project registration token, SSH into Hashiqube

`vagrant ssh`

and enter the following command, remember to change PROJECT_REGISTRATION_TOKEN to your actual project runner Token

```
sudo gitlab-runner register --non-interactive --url "http://localhost:5580" --registration-token "PROJECT_REGISTRATION_TOKEN" --executor "docker" --docker-image alpine:latest --description "docker-runner" --maintenance-note "Free-form maintainer notes about this runner" --tag-list "docker,hashiqube" --run-untagged="true" --locked="false"   --access-level="not_protected"
```

![Gitlab-Runner](images/gitlab-runner.png?raw=true "Gitlab-Runner")
