provider "aws" {
  alias  = "us_east_1"
  region = "us-east-1"
}

resource "aws_ecrpublic_repository" "repository" {
  provider = aws.us_east_1
  for_each = toset(var.ecr_repositories)

  repository_name = each.key

  catalog_data {
    architectures     = ["x86-64"]
    operating_systems = ["Linux"]
  }
}