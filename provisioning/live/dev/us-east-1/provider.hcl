# Here we set region specific common variables. Terragrunt will automatically  
# pull these to root terragrunt.hcl configuration(provisioning/live/terragrunt.hcl) inorder to
# configure the remote backend and also pass forward to the 
# child terragrunt files(provisioning/live/env/region/apps/app_name/terragrunt.hcl) as inputs.

locals {
  env            = "dev"
  aws_region     = "us-east-1"
  owner          = "devops"
  account_name   = "aws-dev"
  aws_account_id = "123456"
  role_name      = "atlantis-iamrole"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
  provider "aws" {
    region = "${local.aws_region}"
    # Only these AWS Account IDs may be operated on by this template
    allowed_account_ids = ["${local.aws_account_id}"]
    assume_role {
      role_arn     = "arn:aws:iam::${local.aws_account_id}:role/${local.role_name}"
    }
  }
EOF
}