variable "ecr_repositories" {
    description = "A list of container repositories"
    default = [
      "pg-s3-backup"
    ]
}