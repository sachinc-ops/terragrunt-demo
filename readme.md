## Terraform + Terragrunt demo

## Prerequisites

* Terraform  >= 1.1.0 installed
* Terragrunt >= 0.36.0 installed
* Authentication method configured to communicate to [AWS](https://www.packer.io/docs/builders/amazon#authentication)


## Usage

```
# Terraform plan
terragrunt plan provisioning/live/<env>/<region>/apps/<app_name>terragrunt.hcl

# Terrafrom apply
terragrunt apply provisioning/live/<env>/<region>/apps/<app_name>terragrunt.hcl
```
