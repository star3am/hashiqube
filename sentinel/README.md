# Sentinel

<div align="center">
  <p><strong>A language and framework for policy decisions across HashiCorp products</strong></p>
</div>

## 🚀 Introduction

[Sentinel](https://docs.hashicorp.com/sentinel/) is a language and framework for policy built to be embedded in existing software to enable fine-grained, logic-based policy decisions. A policy describes under what circumstances certain behaviors are allowed.

Sentinel is an enterprise-only feature of HashiCorp Consul, Nomad, Terraform, and Vault, helping organizations enforce consistent governance across their infrastructure.

## 🛠️ Provision

Choose one of the following methods to set up your environment:

<!-- tabs:start -->

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/star3am/hashiqube?quickstart=1)

```bash
bash docker/docker.sh
bash sentinel/sentinel.sh
```

### **Vagrant**

```bash
vagrant up --provision-with basetools,docsify,sentinel
```

### **Docker Compose**

```bash
docker compose exec hashiqube /bin/bash
bash hashiqube/basetools.sh
bash docker/docker.sh
bash docsify/docsify.sh
bash sentinel/sentinel.sh
```
<!-- tabs:end -->

## 📝 Basic Policy Example

Once installed, you can see Sentinel in action with a simple policy example. Here's a basic policy that checks if the current hour is in the morning (between 0 and 12):

```hcl
hour = 4
main = rule { hour >= 0 and hour < 12 }
```

This policy is saved to `/tmp/policy.sentinel` and then applied using:

```bash
sentinel apply /tmp/policy.sentinel
```

Output:

```bash
Pass
```

## 🔍 Advanced Sentinel Policies

Sentinel can handle complex policy scenarios. Let's explore more advanced examples from the [HashiCorp TFE Policies Example repository](https://github.com/hashicorp/tfe-policies-example).

### AWS Block Allow All CIDR

This policy prevents security groups from using overly permissive CIDR blocks.

#### Testing the Policy

```bash
sentinel test aws-block-allow-all-cidr.sentinel
```

Output:

```bash
PASS - aws-block-allow-all-cidr.sentinel
  PASS - test/aws-block-allow-all-cidr/empty.json
  PASS - test/aws-block-allow-all-cidr/fail.json
  PASS - test/aws-block-allow-all-cidr/pass.json
  ERROR - test/aws-block-allow-all-cidr/plan.json
```

#### Applying the Policy

With a passing configuration:

```bash
sentinel apply -config ./test/aws-block-allow-all-cidr/pass.json aws-block-allow-all-cidr.sentinel
```

Output:

```bash
Pass
```

With a failing configuration:

```bash
sentinel apply -config ./test/aws-block-allow-all-cidr/fail.json aws-block-allow-all-cidr.sentinel
```

Output:

```bash
Fail

Execution trace. The information below will show the values of all
the rules evaluated and their intermediate boolean expressions. Note that
some boolean expressions may be missing if short-circuit logic was taken.
FALSE - aws-block-allow-all-cidr.sentinel:69:1 - Rule "main"
  TRUE - aws-block-allow-all-cidr.sentinel:70:2 - ingress_cidr_blocks
    TRUE - aws-block-allow-all-cidr.sentinel:50:2 - all get_resources("aws_security_group") as sg {
 all sg.applied.ingress as ingress {
  all disallowed_cidr_blocks as block {
   ingress.cidr_blocks not contains block
  }
 }
}
  FALSE - aws-block-allow-all-cidr.sentinel:71:2 - egress_cidr_blocks
    FALSE - aws-block-allow-all-cidr.sentinel:60:2 - all get_resources("aws_security_group") as sg {
 all sg.applied.egress as egress {
  all disallowed_cidr_blocks as block {
   egress.cidr_blocks not contains block
  }
 }
}

FALSE - aws-block-allow-all-cidr.sentinel:59:1 - Rule "egress_cidr_blocks"

TRUE - aws-block-allow-all-cidr.sentinel:49:1 - Rule "ingress_cidr_blocks"
```

### AWS ALB Redirect

This policy ensures that AWS Application Load Balancer listeners use proper redirect status codes.

#### Testing the Policy

```bash
sentinel test aws-alb-redirect.sentinel
```

Output:

```bash
PASS - aws-alb-redirect.sentinel
  PASS - test/aws-alb-redirect/empty.json
  PASS - test/aws-alb-redirect/fail.json
  PASS - test/aws-alb-redirect/pass.json
  ERROR - test/aws-alb-redirect/plan.json
```

#### Applying the Policy

With a failing configuration:

```bash
sentinel apply -config ./test/aws-alb-redirect/fail.json aws-alb-redirect.sentinel
```

Output:

```bash
Fail

Execution trace. The information below will show the values of all
the rules evaluated and their intermediate boolean expressions. Note that
some boolean expressions may be missing if short-circuit logic was taken.
FALSE - aws-alb-redirect.sentinel:69:1 - Rule "main"
  FALSE - aws-alb-redirect.sentinel:70:2 - default_action
    FALSE - aws-alb-redirect.sentinel:49:2 - all get_resources("aws_lb_listener") as ln {
 all ln.applied.default_action as action {

  all action.redirect as rdir {

   rdir.status_code == redirect_status_code
  }
 }
}

FALSE - aws-alb-redirect.sentinel:48:1 - Rule "default_action"
```

With a passing configuration:

```bash
sentinel apply -config ./test/aws-alb-redirect/pass.json aws-alb-redirect.sentinel
```

Output:

```bash
Pass
```

## 💡 Common Use Cases

Sentinel policies can be used to enforce a wide variety of governance requirements:

- **Security**: Ensure resources follow security best practices
- **Compliance**: Enforce regulatory requirements across infrastructure
- **Cost Management**: Prevent deployment of expensive resources
- **Standardization**: Maintain consistent naming and tagging conventions
- **Architecture**: Enforce architectural standards like network configuration

## 📚 Resources

- [Sentinel Documentation](https://docs.hashicorp.com/sentinel/)
- [Sentinel Language Guide](https://docs.hashicorp.com/sentinel/language/)
- [Example Policies Repository](https://github.com/hashicorp/tfe-policies-example)
- [Terraform Cloud Sentinel Examples](https://www.terraform.io/cloud-docs/policy-enforcement/sentinel)
- [Sentinel Playground](https://play.sentinelproject.io/)
