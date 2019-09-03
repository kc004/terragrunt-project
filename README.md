# terragrunt-project
```
First clone this repo.

Create IAM user with these policies - IAM, S3, EC2, VPC, DynamoDB, CloudWatch, CloudTrail
export AWS_ACCESS_KEY=xxxxxx
export AWS_SECRET_KEY=xxxxxx

First let's create stage env.
goto nonprod/stage/
change varibles values from parent terragrunt.hcl and child terragrunt.hcl

terragrunt init
terragrunt plan-all
terragrunt apply-all
```
