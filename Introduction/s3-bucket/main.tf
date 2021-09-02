terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 3.27"
        }
    }
    
}

provider  "aws" {
    profile = "aws-free-tier"
    region  = "us-east-1"
}




resource "aws_s3_bucket" "b" {
  bucket = "my-tf-test-bucket-shafters"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}