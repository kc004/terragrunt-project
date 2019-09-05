#remote_state {
#  backend = "s3"
#  config = {
#    bucket         = "keyur-new-prod"
#    key            = "${path_relative_to_include()}/terraform.tfstate"
#    region         = "eu-west-1"
#    encrypt        = true
#    dynamodb_table = "new-prod-lock-tf"
#  }   
#}
inputs = {
  tags = {
    Environment = "prod"
  }
}