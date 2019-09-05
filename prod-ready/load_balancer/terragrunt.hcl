terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-elb"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc", "../security_group", "../instances"]
}

inputs = {
  name = "prod-elb"
  description = "ELB"
  internal = false
  subnets         = trimspace(run_cmd("terragrunt", "output", "public_subnets", "--terragrunt-working-dir", "../vpc")) #data.aws_subnet_ids.all.ids
  security_groups = [trimspace(run_cmd("terragrunt", "output", "this_security_group_id", "--terragrunt-working-dir", "../security_group"))]
  listener = [
    {
      instance_port     = "80"
      instance_protocol = "HTTP"
      lb_port           = "80"
      lb_protocol       = "HTTP"
    },
  ]
  health_check = {
    target              = "HTTP:80/"
    interval            = 30
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
  }
  number_of_instances = 2
  instances = trimspace(run_cmd("terragrunt", "output", "id", "--terragrunt-working-dir", "../instances")) #["i-0a48fbec6b37913fa", "i-0ef60b20b745031e8"] #
}