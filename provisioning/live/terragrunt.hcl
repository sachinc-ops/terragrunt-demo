locals {
  # Loading repo vars, project vars and AWS account vars
  repo_vars        = read_terragrunt_config(find_in_parent_folders("repo.hcl"))
  provider_vars    = read_terragrunt_config(find_in_parent_folders("provider.hcl"))

  # Extracting common variables for easy use
  repo_name      = local.repo_vars.locals.repo_name
  prj            = local.repo_vars.locals.project
  env            = local.provider_vars.locals.env
  aws_region     = local.provider_vars.locals.aws_region
  aws_account_id = local.provider_vars.locals.aws_account_id
  owner          = local.provider_vars.locals.owner

  # Define common tags for all resources
  common_tags = {
    Terraform_repo = format(
      "https://github.com/sachinc-ops/tree/master/%s/provisioning/live/%s",
      local.repo_name,
      path_relative_to_include()
    )
    cst        = local.prj
    owner      = local.owner
    env        = local.env
    created_by = replace(get_aws_caller_identity_arn(), "/arn.*:/", "")
  }
}

# Generate AWS provider block from provider.hcl file
generate provider {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = local.provider_vars.generate.provider.contents
}

# Configure Terragrunt to automatically store tfstate files in an S3 bucket
remote_state {
  backend = "s3"
  config = {
    encrypt = true
    bucket  = "poc-tfstate"
    key     = "${path_relative_to_include()}/terraform.tfstate"
    region  = "us-east-1"
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}

inputs = merge(
  {
    common_tags = local.common_tags
  },
)
