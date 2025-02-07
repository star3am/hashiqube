# Gitlab
https://docs.gitlab.com/omnibus/docker/ <br />
https://gitlab.com/ <br />

![Gitlab Logo](images/gitlab-logo.png?raw=true "Gitlab Logo")

GitLab is a complete DevOps platform
With GitLab, you get a complete CI/CD toolchain in a single application. One interface. One conversation. One permission model. Thousands of features. You'll be amazed at everything GitLab can do today. And we're just getting started.

You can get Gitlab up and running by running the following command in the hashiqube source repository

:clock3: Duration 15 - 30 minutes <br>
:bangbang: Your Docker daemon should at least have 12G Ram (Gitlab takes 6G alone, Minikube 2G and 2G for the Operating System in Hashiqube) <br>
:bulb: We will bring up the Docker daemon and Minikube and then deploy Gitlab ontop of Minikube using Helm

During the install process you can open the Kubernetes Dashboard once Minikube has been installed - Initally you will see some red as Gitlab pods and services start up, later this will all turn to green.

http://localhost:10888/

![Minikube Dashboard](images/gitlab-install-minikube-dashboard.png?raw=true "Minikube Dashboard")

## Provision

<!-- tabs:start -->
#### **Github Codespaces**

```
bash hashiqube/basetools.sh
bash docker/docker.sh
bash minikube/minikube.sh
bash gitlab/gitlab.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docker,docsify,minikube,gitlab
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash minikube/minikube.sh
bash gitlab/gitlab.sh
```
<!-- tabs:end -->

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')

The above Gitlab provision will look like this

![Gitlab provision](images/gitlab-provision.png?raw=true "Gitlab provision")

You can now login to Gitlab at http://localhost:5580 and login with Username `root` and the password printed out example: `jMh629reoQ7FqtillBmLQZPY69JUStSFATXD11T5wMk39NtNezqIKohcIIwoxwvl`

You can follow along with the rest of the documentation here: <br>
Locally: http://localhost:3333/gitlab/README?id=you-are-here <br>
Hashiqube.com: https://hashiqube.com/gitlab/README?id=you-are-here

## You are here

You have just ran the Gitlab provisioner and Gitlab should now be installed.  

Please login with username __root__ and the password that was printed out
![Gitlab](images/gitlab-login-root-password.png?raw=true "Gitlab")

Now you should be logged into Gitlab, and you will see a page looking like this
![Gitlab](images/gitlab-first-login.png?raw=true "Gitlab")

Now let's create our first project in Gitlab <br>
Click on Create a Project -> Create a Blank project and enter the project name as `test`

Select the namespace as `root` <br>
Make it a Public repository

And click `Create Project`

![Gitlab Create Project](images/gitlab-create-project.png?raw=true "Gitlab Create Project")

Our Test Repository has been created

![Gitlab Create Project](images/gitlab-created-test-project.png?raw=true "Gitlab Create Project")

Now we need to add our SSH key to our User Profile in Gitlab, we can then clone this repository locally, using our SSH keys as authentication. 

To do that, please navigate to Top Left, Click on your Profile Icon image and click on `Preferences`

![Gitlab Preferences](images/gitlab-navigate-to-preferences.png?raw=true "Gitlab Gitlab Preferences")

Now please navigate to `SSH Keys`
![Gitlab Preferences SSH Keys](images/gitlab-navigate-to-preferences-ssh-keys.png?raw=true "Gitlab Gitlab Preferences SSH Keys")

On your laptop in a Terminal Window, please do: 
`cat ~/.ssh/id_rsa.pub` It should look something like this 

```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDIgkrDFTASaZYyJfGd0swmUZaol3JSZmO6D74230CtZjz/YrHq4QL34r5z4oPz9gO8f0l6kN8Hz6BEhAIzArg8kDI9lrsPXypCqlahE49cuzNH3C5GEC9MHo46U6+ZG2IOwCXjiP5ohnXyG8ho8N1BVpDa0xyVevy4COg4malaLVcRwP73YwgxiitNLWcq8k8nB riaan@Riaans-MacBook-Pro.local
```

Copy that key, we will enter it now, navigate back to Gitlab

![Gitlab Enter SSH Keys](images/gitlab-enter-ssh-keys.png?raw=true "Gitlab Gitlab Enter SSH Keys")

:bangbang: Be sure to remove the expiry date and click `Add Key`

![Gitlab Added SSH Keys](images/gitlab-added-ssh-keys.png?raw=true "Gitlab Gitlab Added SSH Keys")

## Clone Test Repo

Now we have a method to authenticate to Gitlab, now we can clone our Test repository we created earlier! 

Navigate back to the home page of Gitlab, and click on your test repository. 

![Gitlab Test Repository](images/gitlab-navigate-to-test-project.png?raw=true "Gitlab Test Repository")

Now, to the right you will see a Clone Button, please click on that, and Copy the `Clone with SSH` link. 

:bangbang: The HTTP Link does not work currently, there is a BUG and i was unable to add the port `5580` in there. So please don't use that, it won;t work.

![Gitlab Clone with SSH Test Repository](images/gitlab-copy-ssh-clone-url-test-project.png?raw=true "Gitlab Clone with SSH Test Repository")

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')

I will clone this to my `~/workspace/personal/test` directory, and I will use this command `git clone ssh://git@localhost:32022/root/test.git` 

The output is below

![Gitlab SSH Clone Test Repository](images/gitlab-ssh-clone-test-project.png?raw=true "Gitlab SSH Clone Test Repository")

## Gitlab Pipeline

Now that we have cloned the Test repository locally, we can add files to it. For our first file we are going to add a `.gitlab-ci.yml` Gitlab Pipeline file. 

So create a new file in the test reposiroty directory, called `.gitlab-ci.yml` with the following content

```yaml
variables:
  REPOSITORY_URL: xxxxxxxxxxxxx.dkr.ecr.eu-west-1.amazonaws.com/container

stages:
  - test
  - build
  - dev
  - stg
  - prd

test:
  stage: test
  script:
    - echo 'Here you can run tests'

build:
  stage: build
  script:
    - echo 'After Test stage was successful, here you can run build your container'

dev:
  stage: dev
  script:
    - echo 'After Build stage was successful, here you can run your Development environment deployment'

stg:
  stage: stg
  script:
    - echo 'After Dev stage was successful, here you can run your Staging environment deployment'

prd:
  stage: prd
  script:
    - echo 'After Stg stage was successful, here you can run your Production environment deployment'
```

Here is a screenshot of what I did, and the commands will be below that you can copy and past. 

![Gitlab add pipeline file to Test Repository](images/gitlab-add-pipeline-file-to-test-repository.png?raw=true "Gitlab add pipeline file to Test Repository")

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')

`cd test`

`nano .gitlab-ci.yml`

`git status`
```
On branch main
Your branch is up to date with 'origin/main'.

Untracked files:
  (use "git add <file>..." to include in what will be committed)
	.gitlab-ci.yml

nothing added to commit but untracked files present (use "git add" to track)
```

`git add .gitlab-ci.yml`

`git commit -am "adding .gitlab-ci.yml pipeline file"`
```
[main 0fe4e09] adding .gitlab-ci.yml pipeline file
 1 file changed, 35 insertions(+)
 create mode 100644 .gitlab-ci.yml
```

`git push`
```
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 10 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 573 bytes | 573.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To ssh://localhost:32022/root/test.git
   29c151b..0fe4e09  main -> main
```

Now when you navigate back to the Gitlab Test Reposiroty and you refresh the page, you will see that our file have been added. 

![Gitlab Test Repository](images/gitlab-added-pipeline-file.png?raw=true "Gitlab Test Repository")

In the next section we will add a Runner to run our pipeline, enjoy! 

## Runners
https://docs.gitlab.com/runner/register/index.html#docker

Let's add a Gitlab runner for our `test` project, please navigate to Settings -> CI/CD 

![Gitlab Navigate to Settings CICD](images/gitlab-navigate-to-settings-cicd.png?raw=true "Gitlab Navigate to Settings CICD")

Now please expand Runners 

![Gitlab Expand Runners](images/gitlab-navigate-to-settings-cicd-expand-runners.png?raw=true "Gitlab Expand Runners")

and click on `New Project Runner`

:bangbang: You can leave everything default, but please Click `Run Untagged Jobs`

![Gitlab New Project Runner](images/gitlab-add-test-project-runners.png?raw=true "Gitlab New Project Runner")

And click on Create Runner. 

Remember that BUG I mentioned above? 
:bug: https://gitlab.com/gitlab-org/charts/gitlab/-/issues/4205

![Gitlab New Project Runner Bug](images/gitlab-add-test-project-runners-bug.png?raw=true "Gitlab New Project Runner Bug")

Well you will now get a blank page, because it redirects us to the URL: http://localhost/root/test/-/runners/1/register?platform=linux

BUT IT SHOULD ACTUALLY BE: 

http://localhost:5580/root/test/-/runners/1/register?platform=linux

So please add the `:5580` after localhost in the URL adrress bar and press enter

![Gitlab Create Project Runner Correct Page](images/gitlab-add-test-project-runners-correct-page.png?raw=true "Gitlab Create Project Runner Correct Page")

## Register Runner

You see the text in Register Runner, Step 1? Copy that, mine looks like below, BUT LOK CLOSELY, You see the BUG again? It's missing the port!! `:5580` 

WRONG!!
```
gitlab-runner register  --url http://localhost  --token glrt-NRYUnqLZ2yzyutC1MYVV
```

So remember to add the port there so that it looks like 

CORRECT!!
```
gitlab-runner register  --url http://localhost:5580  --token glrt-NRYUnqLZ2yzyutC1MYVV
```

Now let's head over to our Hashiqube instance, in our hashiqube directory, we can do

`vagrant ssh`

![Vagrant SSH](images/gitlab-vagrant-ssh-register-runner.png?raw=true "Vagrant SSH")

And we'll register our runner in the Hashiqube instance, be sure to remember to add the port in there 

Now you can do step 3 where we run the runner

`gitlab-runner run`

![Vagrant SSH Gitlab Runner Run](images/gitlab-vagrant-ssh-register-runner-gitlab-runner-run.png?raw=true "Vagrant SSH Gitlab Runner Run")

When you now go back to your Gitlab page you will see :tada: You've created a new runner!

![Vagrant SSH Gitlab Runner Run Success](images/gitlab-vagrant-ssh-register-runner-gitlab-runner-run-success.png?raw=true "Vagrant SSH Gitlab Runner Run Success")

You can now click on Go to the Runners page and you will see it is registered and ready to accept jobs

![Vagrant SSH Gitlab Runners Page](images/gitlab-runners-page-registered.png?raw=true "Vagrant SSH Gitlab Runners Page")

## Run Pipeline

Ok, so we have a Test Project, We have a registered Runner and we have a Pipeline, so let's run our pipeline. Please navigate on your left to `Build - Pipelines`

![Build Pipelines Run](images/gitlab-test-project-run-pipeline.png?raw=true "Build Pipelines Run")

and you will see in the next screen your pipeline is running

![Build Pipelines in progress](images/gitlab-test-project-run-pipeline-in-progress.png?raw=true "Build Pipelines in progress")

To see what the Pipeline Jobs did, please navigate to `Jobs` on the left and then click on one of those jobs

![Build Pipelines Job Details](images/gitlab-test-project-pipeline-job.png?raw=true "Build Pipelines Job Details")

And that's it for now folks, thank you for taking the time to go through this tutorial with me and thank you for using Hashiqube, I hope you had fun! 

## Gitlab Provisioner

[filename](gitlab.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')