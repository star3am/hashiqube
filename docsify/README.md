# Docsify

![Docsify Logo](images/docsify-logo.png?raw=true "Docsify Logo")

In this HashiQube DevOps lab you will get hands on experience with Docsify - The Magical Documentation Generator.

Docsify is a magical documentation site generator. Docsify generates your documentation website on the fly. Unlike GitBook, it does not generate static html files. Instead, it smartly loads and parses your Markdown files and displays them as a website. To start using it, all you need to do is create an index.html and deploy it on GitHub Pages.

## Provision

<!-- tabs:start -->
#### **Github Codespaces**

```
bash hashiqube/basetools.sh
bash docsify/docsify.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docsify
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docsify/docsify.sh
```
<!-- tabs:end -->

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')

## Links 

- https://docsify.js.org/

## Summary
After provision, you can access Docsify and HashiQube documentation at http://localhost:3333/
![Docsify](images/docsify.png?raw=true "Docsify")

## Docsify Provisioner

[filename](docsify.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')