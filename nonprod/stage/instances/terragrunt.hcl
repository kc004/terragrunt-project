terraform {
  source = "github.com/kc004/terragrunt-project-module/modules//instances"
}

dependencies {
  paths = ["../vpc", "../security_groups"]
}

inputs = {
  ami = "ami-03b6f27628a4569c8"  #Ubuntu 18.04
  instance_type = "t2.micro"
  CloudTrailBucketName = "tf-trail-test-keyur"
}

include {
  path = find_in_parent_folders()
}