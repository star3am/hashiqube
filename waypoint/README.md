# Waypoint

https://www.waypointproject.io/

A consistent developer workflow to build, deploy, and release applications across any platform.

![Waypoint Logo](images/waypoint-logo.png?raw=true "Waypoint Logo")

Waypoint supports
- aws-ec2
- aws-ecs
- azure-container-instance
- docker
- exec
- google-cloud-run
- kubernetes
- netlify
- nomad
- pack

In this whiteboard overview, HashiCorp Co-Founder and CTO, Armon Dadgar introduces HashiCorp Waypoint—a project that unifies workflows for build, deploy, and release across platforms. Learn what challenges it is designed to solve and see how it works.

[![Introduction to HashiCorp Waypoint](images/maxresdefault.jpeg)](https://www.youtube.com/watch?v=JL0Qeq4A6So)

https://www.hashicorp.com/blog/announcing-waypoint
https://www.waypointproject.io/

![Hashicorp Waypoint](images/waypoint-workflow.png?raw=true "Hashicorp Waypoint")
![Hashicorp Waypoint](images/waypoint.png?raw=true "Hashicorp Waypoint")
![Hashicorp Waypoint](images/waypoint-nodejs-deployment.png?raw=true "Hashicorp Waypoint")

Waypoint is a wonderful project and it's a firstclass citizen of Hashicorp and runs flawlessly on Nomad. 
To run Waypoint on Nomad do: 

## Waypoint on Nomad

```bash
vagrant up --provision-with basetools,docker,consul,nomad,waypoint
```

Waypoint can also run on Kubernetes and we can test Waypoint using Minikube
To run Waypoint on Kubernetes (Minikube) do: 

## Waypoint on Kubernetes

```bash
vagrant up --provision-with basetools,docker,docsify,minikube,waypoint-kubernetes-minikube
```

To access the documentation site you can run: 

```bash
vagrant up --provision-with docsify
```

`vagrant up --provision-with basetools,docker,docsify,consul,nomad,waypoint`

```log
Bringing machine 'hashiqube0.service.consul' up with 'virtualbox' provider...
==> hashiqube0.service.consul: Checking if box 'ubuntu/bionic64' version '20200429.0.0' is up to date...
==> hashiqube0.service.consul: A newer version of the box 'ubuntu/bionic64' for provider 'virtualbox' is
==> hashiqube0.service.consul: available! You currently have version '20200429.0.0'. The latest is version
==> hashiqube0.service.consul: '20201016.0.0'. Run `vagrant box update` to update.
==> hashiqube0.service.consul: [vagrant-hostsupdater] Checking for host entries
==> hashiqube0.service.consul: [vagrant-hostsupdater]   found entry for: 10.9.99.10 hashiqube0.service.consul
==> hashiqube0.service.consul: [vagrant-hostsupdater]   found entry for: 10.9.99.10 hashiqube0.service.consul
==> hashiqube0.service.consul: Running provisioner: waypoint (shell)...
    hashiqube0.service.consul: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20201019-11073-1uuxwal.sh
    hashiqube0.service.consul: Reading package lists...
    hashiqube0.service.consul: Building dependency tree...
    hashiqube0.service.consul: Reading state information...
    hashiqube0.service.consul: unzip is already the newest version (6.0-21ubuntu1).
    hashiqube0.service.consul: jq is already the newest version (1.5+dfsg-2).
    hashiqube0.service.consul: curl is already the newest version (7.58.0-2ubuntu3.10).
    hashiqube0.service.consul: The following packages were automatically installed and are no longer required:
    hashiqube0.service.consul:   linux-image-4.15.0-99-generic linux-modules-4.15.0-99-generic
    hashiqube0.service.consul: Use 'sudo apt autoremove' to remove them.
    hashiqube0.service.consul: 0 upgraded, 0 newly installed, 0 to remove and 30 not upgraded.
    hashiqube0.service.consul: WARNING! This will remove:
    hashiqube0.service.consul:   - all stopped containers
    hashiqube0.service.consul:   - all networks not used by at least one container
    hashiqube0.service.consul:   - all images without at least one container associated to them
    hashiqube0.service.consul:   - all build cache
    hashiqube0.service.consul:
    hashiqube0.service.consul: Are you sure you want to continue? [y/N]
    hashiqube0.service.consul: Deleted Images:
    hashiqube0.service.consul: deleted: sha256:6a104eb535fb892b25989f966e8775a4adf9b30590862c60745ab78aad58426e
    ...
    hashiqube0.service.consul: untagged: heroku/pack:18
    hashiqube0.service.consul: untagged: heroku/pack@sha256:52f6bc7a03ccf8680948527e51d4b089a178596d8835d8c884934e45272c2474
    hashiqube0.service.consul: deleted: sha256:b7b0e91d132e0874539ea0efa0eb4309a12e322b9ef64852ec05c13219ee2c36
    hashiqube0.service.consul: Total reclaimed space: 977.6MB
    hashiqube0.service.consul: WARNING! This will remove:
    hashiqube0.service.consul:   - all stopped containers
    hashiqube0.service.consul:   - all networks not used by at least one container
    hashiqube0.service.consul:   - all volumes not used by at least one container
    hashiqube0.service.consul:   - all dangling images
    hashiqube0.service.consul:   - all dangling build cache
    hashiqube0.service.consul:
    hashiqube0.service.consul: Are you sure you want to continue? [y/N]
    hashiqube0.service.consul: Deleted Volumes:
    hashiqube0.service.consul: pack-cache-e74b422cf62f.build
    hashiqube0.service.consul: pack-cache-e74b422cf62f.launch
    hashiqube0.service.consul: Total reclaimed space: 179.4MB
    hashiqube0.service.consul: ++++ Waypoint already installed at /usr/local/bin/waypoint
    hashiqube0.service.consul: ++++ Waypoint v0.1.2 (edf37a09)
    hashiqube0.service.consul: ++++ Docker pull Waypoint Server container
    hashiqube0.service.consul: latest:
    hashiqube0.service.consul: Pulling from hashicorp/waypoint
    hashiqube0.service.consul: Digest: sha256:689cae07ac8836ceba1f49c0c36ef57b27ebf61d36009bc309d2198e7825beb9
    hashiqube0.service.consul: Status: Image is up to date for hashicorp/waypoint:latest
    hashiqube0.service.consul: docker.io/hashicorp/waypoint:latest
    hashiqube0.service.consul: waypoint-server
    hashiqube0.service.consul: waypoint-server
    hashiqube0.service.consul: ++++ Waypoint Server starting
    hashiqube0.service.consul: Creating waypoint network...
    hashiqube0.service.consul: Installing waypoint server to docker
    hashiqube0.service.consul:  +: Server container started
    hashiqube0.service.consul: Service ready. Connecting to: localhost:9701
    hashiqube0.service.consul: Retrieving initial auth token...
    hashiqube0.service.consul: ! Error getting the initial token: server is already bootstrapped
    hashiqube0.service.consul:
    hashiqube0.service.consul:   The Waypoint server has been deployed, but due to this error we were
    hashiqube0.service.consul:   unable to automatically configure the local CLI or the Waypoint server
    hashiqube0.service.consul:   advertise address. You must do this manually using "waypoint context"
    hashiqube0.service.consul:   and "waypoint server config-set".
    hashiqube0.service.consul: ++++ Git Clone Waypoint examples
    hashiqube0.service.consul: Cloning into '/tmp/waypoint-examples'...
    hashiqube0.service.consul: -> Validating configuration file...
    hashiqube0.service.consul: -> Configuration file appears valid
    hashiqube0.service.consul: -> Validating server credentials...
    hashiqube0.service.consul: -> Connection to Waypoint server was successful
    hashiqube0.service.consul: -> Checking if project "example-nodejs" is registered...
    hashiqube0.service.consul: -> Project "example-nodejs" and all apps are registered with the server.
    hashiqube0.service.consul: -> Validating required plugins...
    hashiqube0.service.consul: -> Plugins loaded and configured successfully
    hashiqube0.service.consul: -> Checking auth for the configured components...
    hashiqube0.service.consul: -> Checking auth for app: "example-nodejs"
    hashiqube0.service.consul: -> Authentication requirements appear satisfied.
    hashiqube0.service.consul: Project initialized!
    hashiqube0.service.consul: You may now call 'waypoint up' to deploy your project or
    hashiqube0.service.consul: commands such as 'waypoint build' to perform steps individually.
    hashiqube0.service.consul:
    hashiqube0.service.consul: » Building...
    hashiqube0.service.consul: Creating new buildpack-based image using builder: heroku/buildpacks:18
    hashiqube0.service.consul: -> Creating pack client
    hashiqube0.service.consul: -> Building image
    hashiqube0.service.consul: 2020/10/19 00:21:34.146368 DEBUG:  Pulling image index.docker.io/heroku/buildpacks:18
    hashiqube0.service.consul: 18: Pulling from heroku/buildpacks
    6deb54562bfb: Downloading  4.615kB/4.615kB
    ...
6deb54562bfb: Download complete
797d95067ecf: .service.consul:
    hashiqube0.service.consul: Downloading  1.616MB/225.9MB
    ...
4f4fb700ef54: Pull complete l:
    hashiqube0.service.consul: Digest: sha256:27253508524ce1d6bbd70276425f6185743079ac7b389559c18e3f5843491272
    hashiqube0.service.consul: Status: Downloaded newer image for heroku/buildpacks:18
    hashiqube0.service.consul: 2020/10/19 00:22:51.943378 DEBUG:  Selected run image heroku/pack:18
    hashiqube0.service.consul: 2020/10/19 00:22:56.504815 DEBUG:  Pulling image heroku/pack:18
    hashiqube0.service.consul: 18: Pulling from heroku/pack
    hashiqube0.service.consul:
171857c49d0f: Already exists :
    hashiqube0.service.consul:
419640447d26: Already exists :
    hashiqube0.service.consul:
61e52f862619: Already exists :
    hashiqube0.service.consul:
c97d646ce0ef: Already exists :
    hashiqube0.service.consul:
3776f40e285d: Already exists :
    hashiqube0.service.consul:
5ca5846f3d21: Pulling fs layer
6b143b2e1683: Pulling fs layer
6b143b2e1683: Downloading     436B/4.537kB
6b143b2e1683: Downloading  4.537kB/4.537kB
6b143b2e1683: Verifying Checksum
    hashiqube0.service.consul: Download complete
5ca5846f3d21: Extracting      99B/99BB
5ca5846f3d21: Extracting      99B/99B
5ca5846f3d21: Pull complete l:
6b143b2e1683: Extracting  4.537kB/4.537kB
6b143b2e1683: Extracting  4.537kB/4.537kB
6b143b2e1683: Pull complete l:
    hashiqube0.service.consul: Digest: sha256:48e491dd56cc67b120039c958cfddeaf3f8752161efa85756d73c09fde413477
    hashiqube0.service.consul: Status: Downloaded newer image for heroku/pack:18
    hashiqube0.service.consul: 2020/10/19 00:23:02.430378 DEBUG:  Creating builder with the following buildpacks:
    hashiqube0.service.consul: 2020/10/19 00:23:02.430417 DEBUG:  -> heroku/maven@0.1
    hashiqube0.service.consul: 2020/10/19 00:23:02.430423 DEBUG:  -> heroku/jvm@0.1
    hashiqube0.service.consul: 2020/10/19 00:23:02.430427 DEBUG:  -> heroku/java@0.1
    hashiqube0.service.consul: 2020/10/19 00:23:02.430432 DEBUG:  -> heroku/ruby@0.0.1
    hashiqube0.service.consul: 2020/10/19 00:23:02.430436 DEBUG:  -> heroku/procfile@0.5
    hashiqube0.service.consul: 2020/10/19 00:23:02.430439 DEBUG:  -> heroku/python@0.2
    hashiqube0.service.consul: 2020/10/19 00:23:02.430442 DEBUG:  -> heroku/gradle@0.2
    hashiqube0.service.consul: 2020/10/19 00:23:02.430447 DEBUG:  -> heroku/scala@0.2
    hashiqube0.service.consul: 2020/10/19 00:23:02.430451 DEBUG:  -> heroku/php@0.2
    hashiqube0.service.consul: 2020/10/19 00:23:02.430455 DEBUG:  -> heroku/go@0.2
    hashiqube0.service.consul: 2020/10/19 00:23:02.430464 DEBUG:  -> heroku/nodejs-engine@0.4.4
    hashiqube0.service.consul: 2020/10/19 00:23:02.430471 DEBUG:  -> heroku/nodejs-npm@0.2.0
    hashiqube0.service.consul: 2020/10/19 00:23:02.430475 DEBUG:  -> heroku/nodejs-yarn@0.0.1
    hashiqube0.service.consul: 2020/10/19 00:23:02.430483 DEBUG:  -> heroku/nodejs-typescript@0.0.2
    hashiqube0.service.consul: 2020/10/19 00:23:02.430489 DEBUG:  -> heroku/nodejs@0.1
    hashiqube0.service.consul: 2020/10/19 00:23:02.430495 DEBUG:  -> salesforce/nodejs-fn@2.0.1
    hashiqube0.service.consul: 2020/10/19 00:23:02.430505 DEBUG:  -> projectriff/streaming-http-adapter@0.1.3
    hashiqube0.service.consul: 2020/10/19 00:23:02.430528 DEBUG:  -> projectriff/node-function@0.6.1
    hashiqube0.service.consul: 2020/10/19 00:23:02.430534 DEBUG:  -> evergreen/fn@0.2
    hashiqube0.service.consul: 2020/10/19 00:23:06.713138 DEBUG:  Pulling image buildpacksio/lifecycle:0.9.1
    hashiqube0.service.consul: 0.9.1: Pulling from buildpacksio/lifecycle
    hashiqube0.service.consul:
4000adbbc3eb: Pulling fs layer
474f7dcb012d: Pulling fs layer
    ...
474f7dcb012d: Pull complete l:
    hashiqube0.service.consul: Digest: sha256:53bf0e18a734e0c4071aa39b950ed8841f82936e53fb2a0df56c6aa07f9c5023
    hashiqube0.service.consul: Status: Downloaded newer image for buildpacksio/lifecycle:0.9.1
    hashiqube0.service.consul: 2020/10/19 00:23:14.338504 DEBUG:  Using build cache volume pack-cache-e74b422cf62f.build
    hashiqube0.service.consul: 2020/10/19 00:23:14.338523 INFO:   ===> DETECTING
    hashiqube0.service.consul: [detector] ======== Output: heroku/ruby@0.0.1 ========
    hashiqube0.service.consul: [detector] no
    hashiqube0.service.consul: [detector] err:  heroku/ruby@0.0.1 (1)
    hashiqube0.service.consul: [detector] ======== Output: heroku/maven@0.1 ========
    hashiqube0.service.consul: [detector] Could not find a pom.xml file! Please check that it exists and is committed to Git.
    hashiqube0.service.consul: [detector] err:  heroku/maven@0.1 (1)
    hashiqube0.service.consul: [detector] err:  salesforce/nodejs-fn@2.0.1 (1)
    hashiqube0.service.consul: [detector] 3 of 4 buildpacks participating
    hashiqube0.service.consul: [detector] heroku/nodejs-engine 0.4.4
    hashiqube0.service.consul: [detector] heroku/nodejs-npm    0.2.0
    hashiqube0.service.consul: [detector] heroku/procfile      0.5
    hashiqube0.service.consul: 2020/10/19 00:23:15.788888 INFO:   ===> ANALYZING
    hashiqube0.service.consul: [analyzer] Restoring metadata for "heroku/nodejs-engine:nodejs" from app image
    hashiqube0.service.consul: 2020/10/19 00:23:16.543000 INFO:   ===> RESTORING
    hashiqube0.service.consul: [restorer] Removing "heroku/nodejs-engine:nodejs", not in cache
    hashiqube0.service.consul: 2020/10/19 00:23:17.220776 INFO:   ===> BUILDING
    hashiqube0.service.consul: [builder] ---> Node.js Buildpack
    hashiqube0.service.consul: [builder] ---> Installing toolbox
    hashiqube0.service.consul: [builder] ---> - jq
    hashiqube0.service.consul: [builder] ---> - yj
    hashiqube0.service.consul: [builder] ---> Getting Node version
    hashiqube0.service.consul: [builder] ---> Resolving Node version
    hashiqube0.service.consul: [builder] ---> Downloading and extracting Node v12.19.0
    hashiqube0.service.consul: [builder] ---> Parsing package.json
    hashiqube0.service.consul: [builder] ---> Using npm v6.14.8 from Node
    hashiqube0.service.consul: [builder] ---> Installing node modules
    hashiqube0.service.consul: [builder]
    hashiqube0.service.consul: [builder] > ejs@2.7.4 postinstall /workspace/node_modules/ejs
    hashiqube0.service.consul: [builder] > node ./postinstall.js
    hashiqube0.service.consul: [builder]
    hashiqube0.service.consul: [builder] Thank you for installing EJS: built with the Jake JavaScript build tool (https://jakejs.com/)
    hashiqube0.service.consul: [builder]
    hashiqube0.service.consul: [builder] npm WARN node-js-getting-started@0.3.0 No repository field.
    hashiqube0.service.consul: [builder]
    hashiqube0.service.consul: [builder] added 131 packages from 107 contributors and audited 131 packages in 4.554s
    hashiqube0.service.consul: [builder]
    hashiqube0.service.consul: [builder] 26 packages are looking for funding
    hashiqube0.service.consul: [builder]   run `npm fund` for details
    hashiqube0.service.consul: [builder]
    hashiqube0.service.consul: [builder] found 0 vulnerabilities
    hashiqube0.service.consul: [builder]
    hashiqube0.service.consul: [builder] -----> Discovering process types
    hashiqube0.service.consul: [builder]        Procfile declares types     -> web
    hashiqube0.service.consul: 2020/10/19 00:24:22.424730 INFO:   ===> EXPORTING
    hashiqube0.service.consul: [exporter] Reusing layer 'heroku/nodejs-engine:nodejs'
    hashiqube0.service.consul: [exporter] Reusing 1/1 app layer(s)
    hashiqube0.service.consul: [exporter] Reusing layer 'launcher'
    hashiqube0.service.consul: [exporter] Reusing layer 'config'
    hashiqube0.service.consul: [exporter] Adding label 'io.buildpacks.lifecycle.metadata'
    hashiqube0.service.consul: [exporter] Adding label 'io.buildpacks.build.metadata'
    hashiqube0.service.consul: [exporter] Adding label 'io.buildpacks.project.metadata'
    hashiqube0.service.consul: [exporter] *** Images (f58c7abc7584):
    hashiqube0.service.consul: [exporter]       index.docker.io/library/example-nodejs:latest
    hashiqube0.service.consul: [exporter] Adding cache layer 'heroku/nodejs-engine:nodejs'
    hashiqube0.service.consul: [exporter] Adding cache layer 'heroku/nodejs-engine:toolbox'
    hashiqube0.service.consul: -> Injecting entrypoint binary to image
    hashiqube0.service.consul:
    hashiqube0.service.consul: » Deploying...
    hashiqube0.service.consul: -> Setting up waypoint network
    hashiqube0.service.consul: -> Creating new container
    hashiqube0.service.consul: -> Starting container
    hashiqube0.service.consul: -> App deployed as container: example-nodejs-01EMZ3X20HX35FRA3F28AAFHFA
    hashiqube0.service.consul:
    hashiqube0.service.consul: » Releasing...
    hashiqube0.service.consul:
    hashiqube0.service.consul: » Pruning old deployments...
    hashiqube0.service.consul:   Deployment: 01EMT63W8YBMWM5CGK05XGTC44
    hashiqube0.service.consul: Deleting container...
    hashiqube0.service.consul:
    hashiqube0.service.consul: The deploy was successful! A Waypoint deployment URL is shown below. This
    hashiqube0.service.consul: can be used internally to check your deployment and is not meant for external
    hashiqube0.service.consul: traffic. You can manage this hostname using "waypoint hostname."
    hashiqube0.service.consul:
    hashiqube0.service.consul:            URL: https://annually-peaceful-terrapin.waypoint.run
    hashiqube0.service.consul: Deployment URL: https://annually-peaceful-terrapin--v4.waypoint.run
    hashiqube0.service.consul: ++++ Waypoint Server https://localhost:9702 and enter the following Token displayed below
    hashiqube0.service.consul: bM152PWkXxfoy4vA51JFhR7LmV9FA9RLbSpHoKrysFnwnRCAGzV2RExsyAmBrHu784d1WZRW6Cx4MkhvWzkDHvEn49c4wkSZYScfJ
```

## Waypoint Nomad .hcl 

The following Waypoint job file will deploy our Nomad T-Rex NodeJS Application to Nomad

[filename](waypoint/custom-examples/nomad-trex-nodejs/waypoint.hcl ':include :type=code hcl')

## Waypoint Kubernetes .hcl 

The following Waypoint job file will deploy our Nomad T-Rex NodeJS Application to Kubernetes (Minikube)

[filename](waypoint/custom-examples/kubernetes-trex-nodejs/waypoint.hcl ':include :type=code hcl')

## Waypoint T-Rex Dockerfile

Both the Nomad and Kubernetes Applications have a similar Dockerfile

```Dockerfile
# syntax=docker/dockerfile:1

FROM node:14.20.0

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

RUN echo "nameserver 10.9.99.10" > /etc/resolv.conf

EXPOSE 6001

CMD [ "node", "index.js" ]
```

## Waypoint Vagrant Provisioner

`waypoint.sh`

[filename](waypoint.sh ':include :type=code')
