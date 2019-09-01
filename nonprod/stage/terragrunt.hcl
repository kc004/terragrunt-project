remote_state {
  backend = "s3"
  config = {
    encrypt        = true
    bucket         = "keyur-terraform-nonprod-stage"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "terraform-locks-nonprod-stage"
  }
}

inputs = {
  bucket_global = "keyur-terraform-nonprod-stage"
  aws_key_name = "keyur-singapore"
  region = "ap-southeast-1"
  account_name = "stage"          #Account name stage/prod/test
}