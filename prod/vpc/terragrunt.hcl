terraform {
  source = "github.com/kc004/terragrunt-project-module/modules//vpc"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  cidr_prefix = "10.1."
  aws_one_az = "ap-southeast-1a"
  aws_two_az = "ap-southeast-1c"
}