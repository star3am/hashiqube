# Sentinel

https://docs.hashicorp.com/sentinel/
https://github.com/hashicorp/tfe-policies-example
https://docs.hashicorp.com/sentinel/language/

Sentinel is a language and framework for policy built to be embedded in existing software to enable fine-grained, logic-based policy decisions. A policy describes under what circumstances certain behaviors are allowed. Sentinel is an enterprise-only feature of HashiCorp Consul, Nomad, Terraform, and Vault.

## Provision

<!-- tabs:start -->
#### **Github Codespaces**
[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)
```
bash docker/docker.sh
bash sentinel/sentinel.sh
```

#### **Vagrant**

```
vagrant up --provision-with basetools,docsify,sentinel
```

#### **Docker Compose**

```
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash sentinel/sentinel.sh
```
<!-- tabs:end -->

```log
user.local.dev: ++++ Sentinel Simulator v0.9.2 already installed at /usr/local/bin/sentinel
user.local.dev: hour = 4
user.local.dev: main = rule { hour >= 0 and hour < 12 }
user.local.dev: ++++ cat /tmp/policy.sentinel
user.local.dev: hour = 4
user.local.dev: main = rule { hour >= 0 and hour < 12 }
user.local.dev: ++++ sentinel apply /tmp/policy.sentinel
user.local.dev: Pass
user.local.dev: ++++ Let's test some more advanced Sentinel Policies
user.local.dev: ++++ https://github.com/hashicorp/tfe-policies-example
user.local.dev: ++++ https://docs.hashicorp.com/sentinel/language/
user.local.dev: ++++ sentinel test aws-block-allow-all-cidr.sentinel
user.local.dev: PASS - aws-block-allow-all-cidr.sentinel
user.local.dev:   PASS - test/aws-block-allow-all-cidr/empty.json
user.local.dev:   PASS - test/aws-block-allow-all-cidr/fail.json
user.local.dev:   PASS - test/aws-block-allow-all-cidr/pass.json
user.local.dev:   ERROR - test/aws-block-allow-all-cidr/plan.json
user.local.dev:
user.local.dev: ++++ sentinel apply -config ./test/aws-block-allow-all-cidr/pass.json aws-block-allow-all-cidr.sentinel
user.local.dev: Pass
user.local.dev: ++++ sentinel apply -config ./test/aws-block-allow-all-cidr/fail.json aws-block-allow-all-cidr.sentinel
user.local.dev: Fail
user.local.dev:
user.local.dev: Execution trace. The information below will show the values of all
user.local.dev: the rules evaluated and their intermediate boolean expressions. Note that
user.local.dev: some boolean expressions may be missing if short-circuit logic was taken.
user.local.dev: FALSE - aws-block-allow-all-cidr.sentinel:69:1 - Rule "main"
user.local.dev:   TRUE - aws-block-allow-all-cidr.sentinel:70:2 - ingress_cidr_blocks
user.local.dev:     TRUE - aws-block-allow-all-cidr.sentinel:50:2 - all get_resources("aws_security_group") as sg {
user.local.dev: 	all sg.applied.ingress as ingress {
user.local.dev: 		all disallowed_cidr_blocks as block {
user.local.dev: 			ingress.cidr_blocks not contains block
user.local.dev: 		}
user.local.dev: 	}
user.local.dev: }
user.local.dev:   FALSE - aws-block-allow-all-cidr.sentinel:71:2 - egress_cidr_blocks
user.local.dev:     FALSE - aws-block-allow-all-cidr.sentinel:60:2 - all get_resources("aws_security_group") as sg {
user.local.dev: 	all sg.applied.egress as egress {
user.local.dev: 		all disallowed_cidr_blocks as block {
user.local.dev: 			egress.cidr_blocks not contains block
user.local.dev: 		}
user.local.dev: 	}
user.local.dev: }
user.local.dev:
user.local.dev: FALSE - aws-block-allow-all-cidr.sentinel:59:1 - Rule "egress_cidr_blocks"
user.local.dev:
user.local.dev: TRUE - aws-block-allow-all-cidr.sentinel:49:1 - Rule "ingress_cidr_blocks"
user.local.dev:
user.local.dev: ++++ sentinel test aws-alb-redirect.sentinel
user.local.dev: PASS - aws-alb-redirect.sentinel
user.local.dev:   PASS - test/aws-alb-redirect/empty.json
user.local.dev:   PASS - test/aws-alb-redirect/fail.json
user.local.dev:   PASS - test/aws-alb-redirect/pass.json
user.local.dev:   ERROR - test/aws-alb-redirect/plan.json
user.local.dev:
user.local.dev: ++++ sentinel apply -config ./test/aws-alb-redirect/fail.json aws-alb-redirect.sentinel
user.local.dev: Fail
user.local.dev:
user.local.dev: Execution trace. The information below will show the values of all
user.local.dev: the rules evaluated and their intermediate boolean expressions. Note that
user.local.dev: some boolean expressions may be missing if short-circuit logic was taken.
user.local.dev: FALSE - aws-alb-redirect.sentinel:69:1 - Rule "main"
user.local.dev:   FALSE - aws-alb-redirect.sentinel:70:2 - default_action
user.local.dev:     FALSE - aws-alb-redirect.sentinel:49:2 - all get_resources("aws_lb_listener") as ln {
user.local.dev: 	all ln.applied.default_action as action {
user.local.dev:
user.local.dev: 		all action.redirect as rdir {
user.local.dev:
user.local.dev: 			rdir.status_code == redirect_status_code
user.local.dev: 		}
user.local.dev: 	}
user.local.dev: }
user.local.dev:
user.local.dev: FALSE - aws-alb-redirect.sentinel:48:1 - Rule "default_action"
user.local.dev:
user.local.dev: ++++ sentinel apply -config ./test/aws-alb-redirect/pass.json aws-alb-redirect.sentinel
user.local.dev: Pass
```

[google ads](../googleads.html ':include :type=iframe width=100% height=300px')