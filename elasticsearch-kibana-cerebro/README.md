# Elasticsearch, Kibana and Cerebro
https://www.elastic.co/products/elastic-stack <br />
https://github.com/lmenezes/cerebro

## About

__Elasticsearch__ is a distributed, open source search and analytics engine for all types of data, including textual, numerical, geospatial, structured, and unstructured. Elasticsearch is built on Apache Lucene and was first released in 2010 by Elasticsearch N.V. (now known as Elastic).

__Kibana__ is an open source analytics and visualization platform designed to work with Elasticsearch. You use Kibana to search, view, and interact with data stored in Elasticsearch indices. You can easily perform advanced data analysis and visualize your data in a variety of charts, tables, and maps.

__Cerebro__ is an open source(MIT License) elasticsearch web admin tool built using Scala, Play Framework, AngularJS and Bootstrap.

## Provision

`vagrant up --provision-with elasticsearch-kibana-cerebro`

```
Bringing machine 'user.local.dev' up with 'virtualbox' provider...
==> user.local.dev: Checking if box 'ubuntu/xenial64' version '20190918.0.0' is up to date...
==> user.local.dev: A newer version of the box 'ubuntu/xenial64' for provider 'virtualbox' is
==> user.local.dev: available! You currently have version '20190918.0.0'. The latest is version
==> user.local.dev: '20200108.0.0'. Run `vagrant box update` to update.
==> user.local.dev: [vagrant-hostsupdater] Checking for host entries
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: [vagrant-hostsupdater]   found entry for: 10.9.99.10 user.local.dev
==> user.local.dev: Running provisioner: elasticsearch-kibana-cerebro (shell)...
    user.local.dev: Running: /var/folders/7j/gsrjvmds05n53ddg28krf4_80001p9/T/vagrant-shell20200110-34936-91hvdj.sh
    user.local.dev: Error response from daemon: No such container: elasticsearch-kibana
    user.local.dev: Error: No such container: elasticsearch-kibana
    user.local.dev: Error response from daemon: No such container: cerebro
    user.local.dev: Error: No such container: cerebro
    user.local.dev: WARNING! This will remove:
    user.local.dev:   - all stopped containers
    user.local.dev:   - all networks not used by at least one container
    user.local.dev:   - all images without at least one container associated to them
    user.local.dev:   - all build cache
    user.local.dev:
    user.local.dev: Are you sure you want to continue? [y/N]
    user.local.dev: Deleted Containers:
    user.local.dev: 5a9b70a034b784adea91fcb658c1308a56ca0551b270a0cf1dd5e09cb3198364
    user.local.dev: 52141b1df742400671a6de82741268e3f12729079644ad416567ed20df3dfafe
    user.local.dev: bc4ec6c3dd3007d19407a1141e540e5700be83e42dd90f6159e080f48cbed94a
    user.local.dev: 8d496706ebcc9ede4a65562ce6f4622e55701f6496dcc1a8e87feb98e31801e2
    user.local.dev: 099fea1a72903d2b1f55c8faa80f7be797bbc83312776009786665c116fdc286
    user.local.dev: 2899caba5408a79ec646c20b53f9d001c8a51070aa62a53e213c3420ae3435de
    user.local.dev: 72a96d84e9ad23e91a543c58a36ab3a015ee796f7e4ce2ba43dba20a80638daf
    user.local.dev: ba675cb68dbb8e1e3c0ba04f1d465472881b2690b35c4cdb2eca6730c5ae5a4c
    user.local.dev: Deleted Images:
    user.local.dev: untagged: hashicorpnomad/counter-api:v1
    user.local.dev: untagged: hashicorpnomad/counter-api@sha256:f75b2e7204050e37f6aa969e40282f5dfe0b1e367660ecf65bbf3f71fc078f52
    user.local.dev: deleted: sha256:920eaa8f01535d374004289a5f728a890114b3bd38ae71859c50a2c447daf1db
    user.local.dev: deleted: sha256:b0c5001702270e7508c7cf1223d1f18ffc4fbb99f70008643835d325b672652d
    user.local.dev: untagged: ubuntu:16.04
    user.local.dev: untagged: ubuntu@sha256:181800dada370557133a502977d0e3f7abda0c25b9bbb035f199f5eb6082a114
    user.local.dev: deleted: sha256:c6a43cd4801e1cf8832aa1dcda0df1f3730eea7e805be27b24cff32b007a919e
    user.local.dev: deleted: sha256:7cdf8968022e5ad1324543c5d43db8442cb4b6371393d1749875a680ff61c0f3
    user.local.dev: deleted: sha256:a2427c33a3d31bc0eb341b83f535db40e0a87692cdc16a94e3f538f21b90f345
    user.local.dev: deleted: sha256:631b71568d5b1b433e4395f6f748d9095794975743ab17d1fb927e8a21914302
    user.local.dev: deleted: sha256:91d23cf5425acce8ca4402d83139cec63a5547d1a704af63478df008f9b2e4e0
    user.local.dev: untagged: hashicorpnomad/counter-dashboard:v1
    user.local.dev: untagged: hashicorpnomad/counter-dashboard@sha256:37124ddde971d9c377cc64e5a786aec4c0aa77c71d6604515a6968c81fd901ba
    user.local.dev: deleted: sha256:729a950cfecc3f00d00013e90d9d582a6c72fc5806376b1a342c34270ffd8113
    user.local.dev: deleted: sha256:d1d8b278c0ae7666b4cbedc149351b7caa7f79c98c8a37c997b74d44760f3af6
    user.local.dev: deleted: sha256:8bea5b8f64ad56720822bdecb3c4a93dfc5b61b7a75db52deea650e65ced91eb
    user.local.dev: deleted: sha256:3fc64803ca2de7279269048fe2b8b3c73d4536448c87c32375b2639ac168a48b
    user.local.dev: untagged: mysql:latest
    user.local.dev: untagged: mysql@sha256:e1b0fd480a11e5c37425a2591b6fbd32af886bfc6d6f404bd362be5e50a2e632
    user.local.dev: deleted: sha256:ed1ffcb5eff39aed723a66ee895854a6417485f85629de7ba87610beb6bf39ed
    user.local.dev: deleted: sha256:a1baf24e23890cd261b3fb74574bd1ea905b0f9c6008ca304a7c1ef4e238f9fa
    user.local.dev: deleted: sha256:13155cb001017562d45bbc41f578f8be6770163a16fd0121f03501b67e54cd86
    user.local.dev: deleted: sha256:1cd759e6aa7d3cedd5d0c20f16bfe7e7dd91485edaf5cbf0a23bcdccc43aeea8
    user.local.dev: deleted: sha256:e2cef815e506cd47cc6ea937f127d44d7ddf35abee7fb5ece526aaef2e48e71f
    user.local.dev: deleted: sha256:700b12f75e2792a4111743a0aed5078c4d9b4510e68a1f10d8d2452b1d6b48de
    user.local.dev: deleted: sha256:5f7c68324b959d2c806db18d02f153bc810f9842722415e077351bc834cc8578
    user.local.dev: deleted: sha256:338fc0cd3fb4b87a2b83d274e8fbf475fbde19947c4ac5c5eb6e981a6fb0e8f0
    user.local.dev: deleted: sha256:f7a4ccab931f1d1e861961eb951a7806d91ccb375e737fe1f84282f6bbafd2be
    user.local.dev: deleted: sha256:f388e1092f8fb931a3cd07a7381bd9707d19526ff81f8b624e932f4919c27a3e
    user.local.dev: deleted: sha256:e209b7a884b4d2e9d56bbac40ced48f2caa6a19e7ad6eb6dd20ff754f3af2c5d
    user.local.dev: deleted: sha256:2401cf11c5455d505ef49657afcc709197ffcdfc9bd732508e9b62578a30b3a5
    user.local.dev: deleted: sha256:814c70fdae62bc26c603bfae861f00fb1c77fc0b1ee8d565717846f4df24ae5d
    user.local.dev: untagged: apache2:latest
    user.local.dev: deleted: sha256:9f439973e77c469720b8aa99fb5c068522a6b1b48e60f422e1f53cdea27da972
    user.local.dev: deleted: sha256:f1c4fd15a6497707f1d29e7ef5db0cd5f4eb230958ec62da63c5cca00e1c6372
    user.local.dev: deleted: sha256:da4898417ef0e8f196dd2529588460223c7703198e6012d151b6f8235dad8ec4
    user.local.dev: deleted: sha256:b7a2ce270c0df3bffb7385930ee0eb6556fc6fd776eb6271d81713a8850618cc
    user.local.dev: deleted: sha256:88135020f5bd4019c365b04ce1c862ef96918926b9f391ad73d055e973b945ea
    user.local.dev: deleted: sha256:2c649455a07d28ffdde139a859f42079a99740863ade69dae3111703270f772f
    user.local.dev: deleted: sha256:b662b2f695fa29a73abc1aed32deaa8f92fd8533c54245a2f479ea50d860c5e5
    user.local.dev: deleted: sha256:be7201abdb75ca1599441268dc465683b55a0c3f882ec3365f3df09113e04bec
    user.local.dev: deleted: sha256:549b9b86cb8d75a2b668c21c50ee092716d070f129fd1493f95ab7e43767eab8
    user.local.dev: deleted: sha256:7c52cdc1e32d67e3d5d9f83c95ebe18a58857e68bb6985b0381ebdcec73ff303
    user.local.dev: deleted: sha256:a3c2e83788e20188bb7d720f36ebeef2f111c7b939f1b19aa1b4756791beece0
    user.local.dev: deleted: sha256:61199b56f34827cbab596c63fd6e0ac0c448faa7e026e330994818190852d479
    user.local.dev: deleted: sha256:2dc9f76fb25b31e0ae9d36adce713364c682ba0d2fa70756486e5cedfaf40012
    user.local.dev: untagged: fabiolb/fabio:latest
    user.local.dev: untagged: fabiolb/fabio@sha256:b54b0221f2449a7a834ccb6250c9973bc3e4b46fda331179e7cbf53fdcc774a1
    user.local.dev: deleted: sha256:3d652f62fddf53dba25b86b7d2ca7d472abb90dc0f195c0a95758ef540467b42
    user.local.dev: deleted: sha256:a21f99fbd879cdfc883797c193c7819ec6afd0ed62da1c32f113e7fd7b2775d5
    user.local.dev: deleted: sha256:c416d12eb25bfcfa16bf07b80a0b725e002b571e24af05a960d0ba375bad1fb6
    user.local.dev: deleted: sha256:e8d46edebb6b32c34eba453f2e5250effd77ce139fd50fd64ec387b6d93f216b
    user.local.dev: deleted: sha256:03901b4a2ea88eeaad62dbe59b072b28b6efa00491962b8741081c5df50c65e0
    user.local.dev: untagged: localstack/localstack:latest
    user.local.dev: untagged: localstack/localstack@sha256:6a8b0e14e38e3156a2adfbb88f3d11f5f95a95bfb63577e3ad9e42d3d41cc792
    user.local.dev: deleted: sha256:617f5088c7d2c617229db1b6374a10577493a1bf9a8e57bb83b3cddf694bf597
    user.local.dev: deleted: sha256:63d5c75fb453790bf92544f1a4d6f4d0fc29122fd5aab21044e0fddc11c7e4fe
    user.local.dev: untagged: envoyproxy/envoy:v1.11.2
    user.local.dev: untagged: envoyproxy/envoy@sha256:a7769160c9c1a55bb8d07a3b71ce5d64f72b1f665f10d81aa1581bc3cf850d09
    user.local.dev: deleted: sha256:72e91d8680d853b874d9aedda3a4b61048630d2043dd490ff36f5b0929f69874
    user.local.dev: deleted: sha256:4037d8be4277db3eddf0f4c746a38fe2f48ffb1169c49b336844136c0986addc
    user.local.dev: deleted: sha256:3451cdfc98d66494e15e666cb0bd2d379cd9e76cf504df26c6a104624e3e1cab
    user.local.dev: deleted: sha256:71570a7121f5039e0e233eee6dcc2df0654d709550ca127c22584d13bab4c22c
    user.local.dev: deleted: sha256:244e04d48454c14a1a13226a499329aaccf34b1aa157ba89edf2053b415bd111
    user.local.dev: deleted: sha256:ebd7850f89766ceef3b58e315a801315fbac15064163308ddcfce7e9eb05e383
    user.local.dev: deleted: sha256:c1d1d9da605b9e8df0daa35dfb5ddef3ea2b452574137fbb425f43bee509568c
    user.local.dev: deleted: sha256:60db3f0c5d2057f1ca71270cc137c60313f74ae466a7765e12b6a88ba82023fc
    user.local.dev: deleted: sha256:d912b5e4480d3517f2ef887b11aa5cd0cc29c5671423ade238d8540c139cb98e
    user.local.dev: deleted: sha256:ea69392465ad72ace1216ca2f49a372c7d6f10ec031ab53a94a17699c9ab4185
    user.local.dev: untagged: gcr.io/google_containers/pause-amd64:3.0
    user.local.dev: untagged: gcr.io/google_containers/pause-amd64@sha256:163ac025575b775d1c0f9bf0bdd0f086883171eb475b5068e7defa4ca9e76516
    user.local.dev: deleted: sha256:99e59f495ffaa222bfeb67580213e8c28c1e885f1d245ab2bbe3b1b1ec3bd0b2
    user.local.dev: deleted: sha256:666604249ff52593858b7716232097daa6d721b7b4825aac8bf8a3f45dfba1ce
    user.local.dev: deleted: sha256:7897c392c5f451552cd2eb20fdeadd1d557c6be8a3cd20d0355fb45c1f151738
    user.local.dev: deleted: sha256:5f70bf18a086007016e948b04aed3b82103a36bea41755b6cddfaf10ace3c6ef
    user.local.dev: Total reclaimed space: 1.857GB
    user.local.dev: WARNING! This will remove:
    user.local.dev:   - all stopped containers
    user.local.dev:   - all networks not used by at least one container
    user.local.dev:   - all volumes not used by at least one container
    user.local.dev:   - all dangling images
    user.local.dev:   - all dangling build cache
    user.local.dev:
    user.local.dev: Are you sure you want to continue? [y/N]
    user.local.dev: Deleted Volumes:
    user.local.dev: c046eac9db39089c3dd336f2a0c537e6b14d43b035ae3443fe15d3dc0afc11fc
    user.local.dev: Total reclaimed space: 184.6MB
    user.local.dev: Unable to find image 'nshou/elasticsearch-kibana:latest' locally
    user.local.dev: latest:
    user.local.dev: Pulling from nshou/elasticsearch-kibana
    user.local.dev: 169185f82c45: Pulling fs layer
    user.local.dev: 53e52a67e355: Pulling fs layer
    user.local.dev: fc2cb9a5e98e: Pulling fs layer
    user.local.dev: 8ff06045cfc7: Pulling fs layer
    user.local.dev: e6b647406bc4: Pulling fs layer
    user.local.dev: 8ff06045cfc7: Waiting
    user.local.dev: e6b647406bc4: Waiting
    user.local.dev: fc2cb9a5e98e: Verifying Checksum
    user.local.dev: fc2cb9a5e98e: Download complete
    user.local.dev: 169185f82c45:
    user.local.dev: Verifying Checksum
    user.local.dev: 169185f82c45:
    user.local.dev: Pull complete
    user.local.dev: 53e52a67e355:
    user.local.dev: Verifying Checksum
    user.local.dev: 53e52a67e355:
    user.local.dev: Download complete
    user.local.dev: 53e52a67e355:
    user.local.dev: Pull complete
    user.local.dev: 8ff06045cfc7:
    user.local.dev: Verifying Checksum
    user.local.dev: 8ff06045cfc7:
    user.local.dev: Download complete
    user.local.dev: fc2cb9a5e98e:
    user.local.dev: Pull complete
    user.local.dev: 8ff06045cfc7:
    user.local.dev: Pull complete
    user.local.dev: e6b647406bc4: Verifying Checksum
    user.local.dev: e6b647406bc4: Download complete
    user.local.dev: e6b647406bc4:
    user.local.dev: Pull complete
    user.local.dev: Digest: sha256:2d01947ae07b145c2e1ee7e9b2d3e6d823b5201d930b43c5fd3db36f7b8ef22b
    user.local.dev: Status: Downloaded newer image for nshou/elasticsearch-kibana:latest
    user.local.dev: c9ba576ef13ce88aa97f13c30dd3d99e0943a50c4c768e845525f91930536ac6
    user.local.dev: Unable to find image 'lmenezes/cerebro:0.8.3' locally
    user.local.dev: 0.8.3: Pulling from lmenezes/cerebro
    user.local.dev: 27833a3ba0a5: Pulling fs layer
    user.local.dev: 16d944e3d00d: Pulling fs layer
    user.local.dev: 6aaf465b8930: Pulling fs layer
    user.local.dev: 0684138f4cb6: Pulling fs layer
    user.local.dev: 67c4e741e688: Pulling fs layer
    user.local.dev: 08ba3d4c90ec: Pulling fs layer
    user.local.dev: 5f6bc33abf7a: Pulling fs layer
    user.local.dev: 0684138f4cb6: Waiting
    user.local.dev: 67c4e741e688: Waiting
    user.local.dev: 08ba3d4c90ec: Waiting
    user.local.dev: 5f6bc33abf7a: Waiting
    user.local.dev: 16d944e3d00d: Verifying Checksum
    user.local.dev: 16d944e3d00d: Download complete
    user.local.dev: 6aaf465b8930: Download complete
    user.local.dev: 27833a3ba0a5: Verifying Checksum
    user.local.dev: 27833a3ba0a5: Download complete
    user.local.dev: 0684138f4cb6: Verifying Checksum
    user.local.dev: 0684138f4cb6: Download complete
    user.local.dev: 67c4e741e688: Verifying Checksum
    user.local.dev: 67c4e741e688: Download complete
    user.local.dev: 27833a3ba0a5: Pull complete
    user.local.dev: 16d944e3d00d: Pull complete
    user.local.dev: 6aaf465b8930: Pull complete
    user.local.dev: 0684138f4cb6: Pull complete
    user.local.dev: 67c4e741e688: Pull complete
    user.local.dev: 08ba3d4c90ec: Verifying Checksum
    user.local.dev: 08ba3d4c90ec: Download complete
    user.local.dev: 08ba3d4c90ec: Pull complete
    user.local.dev: 5f6bc33abf7a: Download complete
    user.local.dev: 5f6bc33abf7a: Pull complete
    user.local.dev: Digest: sha256:6684131caf5f7427c2a3709bf3bff7bc87ada4d283d2247d53f46dcba48a5755
    user.local.dev: Status: Downloaded newer image for lmenezes/cerebro:0.8.3
    user.local.dev: 68a3f53e8e71ab18b80efc047715bdcfb54205361f01c94fdb809bd812e28ea9
    user.local.dev: ++++ Elasticsearch: http://localhost:9200
    user.local.dev: ++++ Kibana: http://localhost:5601
    user.local.dev: ++++ Cerebro: http://localhost:5602 and enter http://10.9.99.10:9200
```

## Summary
After provision you will have the latest Elasticsearch, Kibana and Cerebro running as Docker containers in your VM, with their ports exposed on your local machine.

__Elasticsearch__<br />
`curl localhost:9200`
```                                                                                    
{
  "name" : "c9ba576ef13c",
  "cluster_name" : "elasticsearch",
  "cluster_uuid" : "OdeMb6s1QO2CUyKLnZ0JJg",
  "version" : {
    "number" : "7.5.1",
    "build_flavor" : "oss",
    "build_type" : "tar",
    "build_hash" : "3ae9ac9a93c95bd0cdc054951cf95d88e1e18d96",
    "build_date" : "2019-12-16T22:57:37.835892Z",
    "build_snapshot" : false,
    "lucene_version" : "8.3.0",
    "minimum_wire_compatibility_version" : "6.8.0",
    "minimum_index_compatibility_version" : "6.0.0-beta1"
  },
  "tagline" : "You Know, for Search"
}
```
__Kibana__ http://localhost:5601

![Kibana](images/kibana.png?raw=true "Kibana")

__Cerebro__ http://localhost:5602

![Cerebro](images/cerebro.png?raw=true "Cerebro")
