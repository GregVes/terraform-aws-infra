variable "ecr_repositories" {
    description = "A list of container repositories"
    default = [
      "db-s3-backup"
    ]
}