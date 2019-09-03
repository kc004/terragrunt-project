variable "region" {
  description = "Name of AWS region"
}

variable "cidrprefix" {
  description = "CIDR prefix for VPC"
}

variable "env" {
  description = "Environment variable"
}

variable "key-name" {
  description = "Key name in that region"
}

variable "amiid" {
  description = "AMI ID"
}

variable "instancetype" {
  description = "Instance type ex. t2.micro"
}

