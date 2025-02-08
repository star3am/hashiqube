# Elasticsearch, Kibana and Cerebro

In this HashiQube DevOps lab you will get hands on experience with Elasticsearch, Kibana and Cerebro.

![Elasticsearch Logo](images/elasticsearch-logo.png?raw=true "Elasticsearch Logo")

__Elasticsearch__ is a distributed, open source search and analytics engine for all types of data, including textual, numerical, geospatial, structured, and unstructured. Elasticsearch is built on Apache Lucene and was first released in 2010 by Elasticsearch N.V. (now known as Elastic).

![Kibana Logo](images/kibana-logo.png?raw=true "Kibana Logo")

__Kibana__ is an open source analytics and visualization platform designed to work with Elasticsearch. You use Kibana to search, view, and interact with data stored in Elasticsearch indices. You can easily perform advanced data analysis and visualize your data in a variety of charts, tables, and maps.

![Kibana Logo](images/cerebro-logo.png?raw=true "Kibana Logo")

__Cerebro__ is an open source(MIT License) elasticsearch web admin tool built using Scala, Play Framework, AngularJS and Bootstrap.

## Provision

<!-- tabs:start -->
#### **Github Codespaces**
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)
```
bash docker/docker.sh
bash elasticsearch-kibana-cerebro/elasticsearch-kibana-cerebro.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docker,docsify,elasticsearch-kibana-cerebro
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash elasticsearch-kibana-cerebro/elasticsearch-kibana-cerebro.sh
```
<!-- tabs:end -->

## Links 

- https://www.elastic.co/products/elastic-stack
- https://github.com/lmenezes/cerebro

__Kibana__ http://localhost:5601

![Kibana](images/kibana.png?raw=true "Kibana")

__Cerebro__ http://localhost:5602

![Cerebro](images/cerebro.png?raw=true "Cerebro")

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')
