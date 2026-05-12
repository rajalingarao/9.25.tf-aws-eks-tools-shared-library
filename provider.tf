terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = ">= 5.48.0" # Terraform AWS provider version
    }
  }
backend "s3" {
  bucket = "jenkins-dev-remote-state"
  key = "jenkins-dev-tools"
  region = "us-east-1"
  dynamodb_table="jenkins-dev-locking"
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}
