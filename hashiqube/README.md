# Hashiqube

![Hashiqube Logo](images/logo-qube.png?raw=true "Hashiqube Logo")

This Provider (Basetools) installs some essential tools that Hashiqube provisioners need, this is one of the first provisioners that has to be run. Amongst other it also installs Python and Pip and sets the Message of the Day MOTD. 

```
swapspace rkhunter jq curl unzip software-properties-common bzip2 git make python3.9 python3-pip python3-dev python3-venv python3-virtualenv golang-go apt-utils ntp update-motd toilet figlet nano iputils-ping dnsutils iptables telnet
```

## Hashiqune Vagrant Provisioner

[filename](basetools.sh ':include :type=code')

## Hashiqube.com 
__WORK IN PROGRESS__

As you can already imagine, I am using Hashicorp tools to deploy Hashiqube.com website - For this I use Hashiqube and more specifically, Waypoint.

### Bring up Hashiqube locally
`vagrant up --provision-with basetools,docker,terraform,nomad,waypoint`

### SSH into Hashiqube
`vagrant ssh`

### Set AWS Credentials
`~/.aws/config`
```
[default]
region =
aws_access_key_id =
aws_secret_access_key =
output = json
```

### Change Directory
`cd /vagrant`

### Waypoint Init
```log
✓ Configuration file appears valid
✓ Connection to Waypoint server was successful
✓ Project "hashiqube" and all apps are registered with the server.
✓ Project "hashiqube" pipelines are registered with the server.

Project initialized!

You may now call 'waypoint up' to deploy your project or
commands such as 'waypoint build' to perform steps individually.
```
### Waypoint Up to build and deploy
`waypoint up`

```log
» Performing operation locally

» Building hashiqube...
✓ Running build v6
✓ All services available.
✓ Set ECR Repository name to 'hashiqube'
✓ Initializing Docker client...
✓ Building image...
 │ Step 6/7 : EXPOSE 3000/tcp
 │  ---> Running in 23af06f1e141
 │ Removing intermediate container 23af06f1e141
 │  ---> 1ec08a9809e7
 │ Step 7/7 : ENTRYPOINT docsify serve --port 3000 .
 │  ---> Running in 979e0a2b31ba
 │ Removing intermediate container 979e0a2b31ba
 │  ---> ce95edf92a1d
 │ Successfully built ce95edf92a1d
 │ Successfully tagged waypoint.local/hashiqube:latest
✓ Injecting Waypoint Entrypoint...
Image built: waypoint.local/hashiqube:latest (arm64)
✓ Running push build v3
✓ All services available.
✓ Set ECR Repository name to 'hashiqube'
✓ Tagging Docker image: waypoint.local/hashiqube:latest => 241803818300.dkr.ecr.ap-southeast-2.amazonaws.com/hashiqube:latest
✓ Pushing Docker image...
 │ b834e6addace: Layer already exists
 │ 01cc858d0ddb: Layer already exists
 │ 9c1364bce9cb: Layer already exists
 │ a85b326ea208: Layer already exists
 │ bebb780c89cf: Layer already exists
 │ 611bfb08f71c: Layer already exists
 │ 0008bb42e2e6: Layer already exists
 │ b89248fb99be: Layer already exists
 │ latest: digest: sha256:fb440d4946c6195d44106bb100b4761c0e2e5b74ae211c14339388462
 │ 5e82f05 size: 2639
✓ Docker image pushed: 241803818300.dkr.ecr.ap-southeast-2.amazonaws.com/hashiqube:latest

» Deploying hashiqube...
✓ Running deploy v3
✓ Deployment resources created
✓ Discovered alb subnets
✓ Discovered service subnets
✓ Using existing execution IAM role "ecr-hashiqube"
✓ Using existing log group waypoint-logs
✓ Registered Task definition: waypoint-hashiqube
✓ Using external security group hashiqube-inbound
✓ Using internal security group hashiqube-inbound-internal
✓ Created target group hashiqube-01H3KF9QR2CYEM6NPC334A
✓ Using Application Load Balancer "waypoint-ecs-hashiqube"
✓ Created ALB Listener
✓ Using existing ECS cluster waypoint
✓ Created ECS Service hashiqube-01H3KF9QR2CYEM6NPC334A
✓ Finished building report for ecs deployment
✓ Determining status of ecs service hashiqube-01H3KF9QR2CYEM6NPC334A
✓ Found existing ECS cluster: waypoint
⚠️ 1 cluster READY, 1 service READY, 1 task MISSING
⚠️ Waypoint detected that the current deployment is not ready, however your application
might be available or still starting up.

✓ Finished building report for ecs deployment
✓ Determining status of ecs service hashiqube-01H3KF9QR2CYEM6NPC334A
✓ Found existing ECS cluster: waypoint
⚠️ 1 cluster READY, 1 service READY, 1 task MISSING
⚠️ Waypoint detected that the current deployment is not ready, however your application
might be available or still starting up.

» Releasing hashiqube...
✓ Running release v3
✓ Release initialized
✓ All targets are healthy!
✓ Finished ECS release


» Variables used:
  VARIABLE | VALUE | TYPE | SOURCE  
-----------+-------+------+---------


The deploy was successful! A Waypoint deployment URL is shown below. This
can be used internally to check your deployment and is not meant for external
traffic. You can manage this hostname using "waypoint hostname."

   Release URL: http://waypoint-ecs-hashiqube-117608968.ap-southeast-2.elb.amazonaws.com
Deployment URL: https://sharply-composed-flea--v3.waypoint.run
```

### Waypoint Destroy
`waypoint destroy`

```log
Do you really want to destroy all resources for this app? Only 'yes' will be accepted to approve: yes


» Performing operation locally

» Destroying releases for application 'hashiqube'...
✓ Running release destroy v3
...
✓ Running release destroy v3

» Destroying deployments for application 'hashiqube'...
✓ Running deployment destroy v3
✓ Finished destroying ECS deployment
✓ Deleted service hashiqube-01H3KF9QR2CYEM6NPC334A
✓ Deleted ALB Listener
✓ Retrieved target group details
✓ ALB listener for target group is deleted
✓ Target group deleted
These resources were not destroyed for app "hashiqube":
- route53 record
- cluster
- execution role
- log group
- internal security groups
- service subnets
- task role
- alb subnets

These resources were destroyed for app "hashiqube":
- external security groups
- alb listener
- task definition
- service
- application load balancer
- target group


» Destroying shared deploy resources for application 'hashiqube'...
✓ Finished destroying ECS deployment
✓ ALB is managed by Waypoint - proceeding with deletion
✓ Deleted ALB arn:aws:elasticloadbalancing:ap-southeast-2:241803818300:loadbalancer/app/waypoint-ecs-hashiqube/ed3b1d6b31e1b58d
✓ Deleted security group sg-03f10a91f6ee3d10a
✓ Deleted security group sg-0fe1d9ac18497255d
✓ Deleted ECS task definition
Destroy successful!
```