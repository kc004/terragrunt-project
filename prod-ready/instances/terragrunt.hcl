terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-ec2-instance"
}

include {
  path = find_in_parent_folders()
}

dependencies {
  paths = ["../vpc", "../security_group"]
}

inputs = {
  name = "prod-instance-"
  description = "Ec2 instances"
  vpc_id = trimspace(run_cmd("terragrunt", "output", "vpc_id", "--terragrunt-working-dir", "../vpc"))
  instance_count = 2
  instance_type = "t2.micro"
  ami = "ami-06358f49b5839867c"
  key_name = "keyur-ireland"
  vpc_security_group_ids = [trimspace(run_cmd("terragrunt", "output", "this_security_group_id", "--terragrunt-working-dir", "../security_group"))]  #["sg-028a342d8951e9247"] #
  subnet_id = trimspace(run_cmd("terragrunt", "output", "private_subnets", "--terragrunt-working-dir", "../vpc")) #"subnet-079f8481c22fed90e"
}

  
  