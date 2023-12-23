# Trex

Dinosaur T-Rex Game

This Easter Egg is usually hidden on the No Internet connection error page in Google's Chrome web browser and played offline. Here, however, you can play the hacked Dino T-Rex Runner Game on Hashiqube. 

Press the space bar to start the game and also to jump over the obstacles.

In Hashiqube, I use it as a demo application when I do presentations.

Enjoy! 

![Trex Game](images/trex.png?raw=true "Trex Game")

## Provision

`vagrant up --provision-with basetools,docker,docsify,trex`

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')

```log
Bringing machine 'hashiqube0' up with 'docker' provider...
==> hashiqube0: Running provisioner: trex (shell)...
    hashiqube0: Running: /var/folders/24/42plvkmn3313qkrvqjr3nqph0000gn/T/vagrant-shell20230921-80278-h7ejsj.sh
    hashiqube0: Error response from daemon: No such container: trex
    hashiqube0: Error response from daemon: No such container: trex
    hashiqube0: WARNING! This will remove:
    hashiqube0:   - all stopped containers
    hashiqube0:   - all networks not used by at least one container
    hashiqube0:   - all images without at least one container associated to them
    hashiqube0:   - all build cache
    hashiqube0:
    hashiqube0: Are you sure you want to continue? [y/N] Total reclaimed space: 0B
    hashiqube0: WARNING! This will remove:
    hashiqube0:   - all stopped containers
    hashiqube0:   - all networks not used by at least one container
    hashiqube0:   - all anonymous volumes not used by at least one container
    hashiqube0:   - all dangling images
    hashiqube0:   - all dangling build cache
    hashiqube0:
    hashiqube0: Are you sure you want to continue? [y/N] Total reclaimed space: 0B
    hashiqube0: ++++
    hashiqube0: ++++ Docker build -t trex .
    hashiqube0: ++++
    hashiqube0: #0 building with "default" instance using docker driver
    hashiqube0:
    hashiqube0: #1 [internal] load build definition from Dockerfile
    hashiqube0: #1 transferring dockerfile: 192B done
    hashiqube0: #1 DONE 0.0s
    hashiqube0:
    hashiqube0: #2 [internal] load .dockerignore
    hashiqube0: #2 transferring context: 2B done
    hashiqube0: #2 DONE 0.0s
    hashiqube0:
    hashiqube0: #3 resolve image config for docker.io/docker/dockerfile:1
    hashiqube0: #3 DONE 3.4s
    hashiqube0:
    hashiqube0: #4 docker-image://docker.io/docker/dockerfile:1@sha256:ac85f380a63b13dfcefa89046420e1781752bab202122f8f50032edf31be0021
    hashiqube0: #4 resolve docker.io/docker/dockerfile:1@sha256:ac85f380a63b13dfcefa89046420e1781752bab202122f8f50032edf31be0021
    hashiqube0: #4 resolve docker.io/docker/dockerfile:1@sha256:ac85f380a63b13dfcefa89046420e1781752bab202122f8f50032edf31be0021 1.5s done
    hashiqube0: #4 sha256:cf80d9b4bd1c75ee551ce5ff6f950a178fbb62e661c02e42d41b8c772d1efc1d 0B / 11.02MB 0.1s
    hashiqube0: #4 sha256:ac85f380a63b13dfcefa89046420e1781752bab202122f8f50032edf31be0021 8.40kB / 8.40kB done
    hashiqube0: #4 sha256:e929b0d024894103bb3a8577aad825a7df006a8f6767747bffd373d804c3ee67 482B / 482B done
    hashiqube0: #4 sha256:19c37871da0fa7da4b2a871455ccea62d3b08eb94a7f6f0cf310fe02f14f5089 1.27kB / 1.27kB done
    hashiqube0: #4 sha256:cf80d9b4bd1c75ee551ce5ff6f950a178fbb62e661c02e42d41b8c772d1efc1d 2.10MB / 11.02MB 0.7s
    hashiqube0: #4 sha256:cf80d9b4bd1c75ee551ce5ff6f950a178fbb62e661c02e42d41b8c772d1efc1d 4.19MB / 11.02MB 0.8s
    hashiqube0: #4 sha256:cf80d9b4bd1c75ee551ce5ff6f950a178fbb62e661c02e42d41b8c772d1efc1d 6.29MB / 11.02MB 1.0s
    hashiqube0: #4 sha256:cf80d9b4bd1c75ee551ce5ff6f950a178fbb62e661c02e42d41b8c772d1efc1d 7.34MB / 11.02MB 1.1s
    hashiqube0: #4 sha256:cf80d9b4bd1c75ee551ce5ff6f950a178fbb62e661c02e42d41b8c772d1efc1d 8.39MB / 11.02MB 1.5s
    hashiqube0: #4 sha256:cf80d9b4bd1c75ee551ce5ff6f950a178fbb62e661c02e42d41b8c772d1efc1d 10.49MB / 11.02MB 1.6s
    hashiqube0: #4 extracting sha256:cf80d9b4bd1c75ee551ce5ff6f950a178fbb62e661c02e42d41b8c772d1efc1d
    hashiqube0: #4 sha256:cf80d9b4bd1c75ee551ce5ff6f950a178fbb62e661c02e42d41b8c772d1efc1d 11.02MB / 11.02MB 1.6s done
    hashiqube0: #4 extracting sha256:cf80d9b4bd1c75ee551ce5ff6f950a178fbb62e661c02e42d41b8c772d1efc1d 0.2s done
    hashiqube0: #4 DONE 3.3s
    hashiqube0:
    hashiqube0: #5 [internal] load build definition from Dockerfile
    hashiqube0: #5 DONE 0.0s
    hashiqube0:
    hashiqube0: #6 [internal] load metadata for docker.io/library/node:14.20.0
    hashiqube0: #6 DONE 4.7s
    hashiqube0:
    hashiqube0: #7 [internal] load .dockerignore
    hashiqube0: #7 DONE 0.0s
    hashiqube0:
    hashiqube0: #8 [1/5] FROM docker.io/library/node:14.20.0@sha256:6adfb0c2a9db12a06893974bb140493a7482e2b3df59c058590594ceecd0c99b
    hashiqube0: #8 resolve docker.io/library/node:14.20.0@sha256:6adfb0c2a9db12a06893974bb140493a7482e2b3df59c058590594ceecd0c99b done
    hashiqube0: #8 DONE 0.0s
    hashiqube0:
    hashiqube0: #9 [internal] load build context
    hashiqube0: #9 transferring context: 30B
    hashiqube0: #9 transferring context: 669.91kB 0.0s done
    hashiqube0: #9 DONE 0.0s
    hashiqube0:
    hashiqube0: #10 [2/5] WORKDIR /app
    hashiqube0: #10 DONE 0.0s
    hashiqube0:
    hashiqube0: #11 [3/5] COPY package*.json ./
    hashiqube0: #11 DONE 0.0s
    hashiqube0:
    hashiqube0: #12 [4/5] RUN npm install
    hashiqube0: #12 22.91
    hashiqube0: #12 22.91 > ejs@2.7.4 postinstall /app/node_modules/ejs
    hashiqube0: #12 22.91 > node ./postinstall.js
    hashiqube0: #12 22.91
    hashiqube0: #12 22.94 Thank you for installing EJS: built with the Jake JavaScript build tool (https://jakejs.com/)
    hashiqube0: #12 22.94
    hashiqube0: #12 22.98 npm notice created a lockfile as package-lock.json. You should commit this file.
    hashiqube0: #12 22.99 npm WARN node-js-getting-started@0.3.0 No repository field.
    hashiqube0: #12 22.99
    hashiqube0: #12 22.99 added 158 packages from 105 contributors and audited 158 packages in 22.627s
    hashiqube0: #12 23.01
    hashiqube0: #12 23.01 67 packages are looking for funding
    hashiqube0: #12 23.01   run `npm fund` for details
    hashiqube0: #12 23.01
    hashiqube0: #12 23.01 found 1 critical severity vulnerability
    hashiqube0: #12 23.01   run `npm audit fix` to fix them, or `npm audit` for details
    hashiqube0: #12 DONE 23.0s
    hashiqube0:
    hashiqube0: #13 [5/5] COPY . .
    hashiqube0: #13 DONE 0.0s
    hashiqube0:
    hashiqube0: #14 exporting to image
    hashiqube0: #14 exporting layers
    hashiqube0: #14 exporting layers 0.2s done
    hashiqube0: #14 writing image sha256:a637a34b9c1f7dc45f89a9c9b135c40737798f69c12cc451dbbf3d1a3311b5b8 done
    hashiqube0: #14 naming to docker.io/library/trex done
    hashiqube0: #14 DONE 0.2s
    hashiqube0: ++++
    hashiqube0: ++++ Docker images --filter reference=trex
    hashiqube0: ++++
    hashiqube0: REPOSITORY   TAG       IMAGE ID       CREATED        SIZE
    hashiqube0: trex         latest    a637a34b9c1f   1 second ago   881MB
    hashiqube0: ++++
    hashiqube0: ++++ Docker run -t -d -i -p 6001:6001 --name trex --rm trex
    hashiqube0: ++++
    hashiqube0: de20c407ad8096dcec0132da82f188c5b486fe75af55c3573882a92adc110abc
    hashiqube0: ++++
    hashiqube0: ++++ Docker ps -f name=trex
    hashiqube0: ++++
    hashiqube0: CONTAINER ID   IMAGE          COMMAND                  CREATED                  STATUS                  PORTS                                                              NAMES
    hashiqube0: de20c407ad80   trex           "docker-entrypoint.s…"   Less than a second ago   Up Less than a second   0.0.0.0:6001->6001/tcp                                             trex
    hashiqube0: 9ecf6bd1a0c1   e48e9dd0ad14   "/waypoint-entrypoin…"   4 minutes ago            Up 4 minutes            6001/tcp, 172.17.0.2:20226->3000/tcp, 172.17.0.2:20226->3000/udp   nomad-trex-nodejs-01hatqqqvjr8jh0mffn1s0kbg6-0d169154-44e5-3ab0-6997-8297c9b33b6a
    hashiqube0: 614d0b37c55c   e48e9dd0ad14   "/waypoint-entrypoin…"   4 minutes ago            Up 4 minutes            6001/tcp, 172.17.0.2:20700->3000/tcp, 172.17.0.2:20700->3000/udp   nomad-trex-nodejs-01hatqqnvk93he806bfgddj188-fff45d50-8904-690f-76bd-abbbf7e3091c
    hashiqube0: ++++ Open http://localhost:6001 in your browser
```

## Provisioner

[filename](trex.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')