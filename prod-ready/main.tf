provider "aws" {
  region = "${var.region}"
}

terraform {
  backend "s3" {}
}

data "aws_availability_zones" "available" {
}

########
# VPC  #
########

module "vpc" {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc/"
  name = "${var.env}-vpc"
  cidr = "${var.cidrprefix}0.0/16"
  azs                = [data.aws_availability_zones.available.names[0], data.aws_availability_zones.available.names[1]]
  private_subnets    = ["${var.cidrprefix}1.0/24", "${var.cidrprefix}2.0/24"]
  public_subnets     = ["${var.cidrprefix}101.0/24", "${var.cidrprefix}102.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  tags = {
    Environment = "${var.env}"
  }
  vpc_tags = {
    Name = "${var.env}-vpc"
  }
}

###################
# Security Group  #
###################

module "security_group" {
  source  = "github.com/terraform-aws-modules/terraform-aws-security-group"
  name        = "${var.env}-sg"
  description = "Security group for VPC"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["all-all"]
  egress_rules        = ["all-all"]
}

module "instance_security_group" {
  source  = "github.com/terraform-aws-modules/terraform-aws-security-group"
  name        = "instance-prod-sg"
  description = "Security group for load balancer"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp","https-443-tcp","ssh-tcp"]
  egress_rules        = ["all-all"]
}

########
# EC2  #
########
module "ec2_instance1" {
  source                 = "github.com/terraform-aws-modules/terraform-aws-ec2-instance"
  name                   = "${var.env}-instance-1"
  instance_count         = 1
  ami                    = "${var.amiid}"
  instance_type          = "${var.instancetype}"
  key_name               = "${var.key-name}"
  vpc_security_group_ids = [module.instance_security_group.this_security_group_id]
  subnet_id              = module.vpc.private_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "${var.env}"
  }
}
module "ec2_instance2" {
  source                 = "github.com/terraform-aws-modules/terraform-aws-ec2-instance"
  name                   = "${var.env}-instance-2"
  instance_count         = 1
  ami                    = "${var.amiid}"
  instance_type          = "${var.instancetype}"
  key_name               = "${var.key-name}"
  vpc_security_group_ids = [module.instance_security_group.this_security_group_id]
  subnet_id              = module.vpc.private_subnets[1]
  tags = {
    Terraform   = "true"
    Environment = "${var.env}"
  }
}

########
# ELB  #
########

module "elb_prod" {
  source  = "github.com/terraform-aws-modules/terraform-aws-elb"
  name = "${var.env}-elb"
  subnets         = [module.vpc.public_subnets[0]]
  security_groups = [module.instance_security_group.this_security_group_id]
  internal        = false
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
  tags = {
    Environment = "${var.env}"
  }
  number_of_instances = 2
  instances           = [module.ec2_instance1.id[0], module.ec2_instance2.id[0]]

}
