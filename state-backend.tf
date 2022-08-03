terraform {
  backend "s3" {
    bucket = "gregentoo-terraform-backend"
    key    = "tf-mod-users.tfstate"
    region = "eu-central-1"
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}
