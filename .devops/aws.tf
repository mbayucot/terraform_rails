terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.68"
    }
  }
}

provider "aws" {
  profile                 = "demo"
  region                  = "us-east-1"
  shared_credentials_file = "~/.aws/credentials"
}
