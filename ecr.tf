resource "aws_ecrpublic_repository" "repository" {
  for_each = toset(var.ecr_repositories)

  repository_name = each.key

  catalog_data {
    architectures     = ["x86-64"]
    operating_systems = ["Linux"]
  }

  tags = {
    managed_by = "Terraform"
  }
}