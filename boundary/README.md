# Boundary

![Boundary Logo](images/boundary-logo.png?raw=true "Boundary Logo")

In this HashiQube DevOps lab you will get hands on experience with HashiCorp Boundary.

Boundary is designed to grant access to critical systems using the principle of least privilege, solving challenges organizations encounter when users need to securely access applications and machines. Traditional products that grant access to systems are cumbersome, painful to maintain, or are black boxes lacking extensible APIs. Boundary allows authenticated and authorized users to access secure systems in private networks without granting access to the larger network where those systems reside.

In this whiteboard overview, HashiCorp Co-Founder and CTO, Armon Dadgar introduces HashiCorp Boundary—a identity-based secure access management solution. Learn what challenges it is designed to solve and see how it works.

## Latest News

- [Boundary 0.12 introduces multi-hop sessions and SSH certificate injection](https://www.hashicorp.com/blog/boundary-0-12-introduces-multi-hop-sessions-and-ssh-certificate-injection)
- [Boundary 0.10 Expands Credential Management and Admin UI IAM Workflows](https://www.hashicorp.com/blog/boundary-0-10-expands-credential-management-and-admin-ui-iam-workflows)
- [HashiCorp Boundary 0.8 Expands Health and Events Observability](https://www.hashicorp.com/blog/hashicorp-boundary-0-8-expands-health-and-events-observability)

## Introduction

[![Introduction to HashiCorp Boundary](images/maxresdefault.jpeg)](https://www.youtube.com/watch?v=tUMe7EsXYBQ)

![Hashicorp Boundary](images/boundary-how-it-works.png?raw=true "Hashicorp Boundary")

![Hashicorp Boundary](images/boundary-login-page.png?raw=true "Hashicorp Boundary")

![Hashicorp Boundary](images/boundary-logged-in-page.png?raw=true "Hashicorp Boundary")

## Provision

<!-- tabs:start -->
#### **Github Codespaces**
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)
```
bash boundary/boundary.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docsify,boundary
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docsify/docsify.sh
bash boundary/boundary.sh
```
<!-- tabs:end -->

## Links 

- https://www.boundaryproject.io/

## Boundary Vagrant Provisioner

`boundary.sh`

[filename](boundary.sh ':include :type=code')

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')