terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket         = "remote-state-90s-dev"
    key            = "roboshop-databases.tfstate"
    region         = "us-east-1"
    encrypt        = true
    use_lockfile   = true # Enables native S3 state locking (Terraform 1.10+)
  }
}

provider "aws" {
  region = "us-east-1"
}