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

