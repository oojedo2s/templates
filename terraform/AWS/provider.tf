terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.26.0"
    }
  }
}

provider "aws" {
  # Configuration options
  profile                 = "default"
  region                  = var.region
  shared_credentials_file = "~/tutorial/awskey"
}