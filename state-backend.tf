terraform {
  backend "s3" {
    bucket = "gregentoo-tf-state-backend"
    key    = "tf-aws-infra.tfstate"
    region = "eu-central-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}