terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-security-group"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc"]
}

inputs = {
  name = "instance-prod-sg"
  description = "Security group for load balancer"
  vpc_id              = trimspace(run_cmd("terragrunt", "output", "vpc_id", "--terragrunt-working-dir", "../vpc"))
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp","https-443-tcp","ssh-tcp"]
  egress_rules        = ["all-all"]
}