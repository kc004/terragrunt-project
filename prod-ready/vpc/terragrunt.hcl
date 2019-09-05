terraform {
  source = "github.com/terraform-aws-modules/terraform-aws-vpc/"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  name = "prod-vpc"
  cidr = "10.1.0.0/16"
  region = "eu-west-1"
  azs                = ["eu-west-1a", "eu-west-1b"]
  private_subnets    = ["10.1.1.0/24", "10.1.2.0/24"]
  public_subnets     = ["10.1.101.0/24", "10.1.102.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  vpc_tags = {
    Name = "prod-vpc"
  }
}