terraform {
  source = "github.com/kc004/terragrunt-project-module/modules//load_balancer"
}

dependencies {
  paths = ["../vpc", "../security_groups", "../instances"]
}

include {
  path = find_in_parent_folders()
}

inputs = {
  lb_name = "dev-lb" 
}