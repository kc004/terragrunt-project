remote_state {
  backend = "s3"
  config = {
    bucket         = "test-new-prod"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "eu-west-1"
    encrypt        = true
    dynamodb_table = "new-prod-lock-tf"
  }   
}
inputs = {
  region = "eu-west-1"
  cidrprefix = "10.1."
  env = "prod"
  key-name = "keyur-ireland"
  amiid = "ami-06358f49b5839867c"
  instancetype = "t2.micro"
}