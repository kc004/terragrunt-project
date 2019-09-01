terraform {
  source = "github.com/kc004/terragrunt-project-module/modules//security_groups"
}

dependencies {
  paths = ["../vpc"]
}

include {
  path = find_in_parent_folders()
}
