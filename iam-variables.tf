variable "cluster_cidr_ranges" {
  description = "CIDR ranges where cluster is located"
  default = [
    "51.83.179.16/32",
    "51.83.147.42/32"
  ]
}

variable "synapse_dev_s3_actions" {
  description = "List action for Terraform backend object"
  default = [
    "s3:GetObject",
    "s3:PutObject",
    "s3:DeleteObject",
  ]
}

variable "users" {
  description = "A list of users objects"
  default = [
    {
      name = "service_synapse_dev"
      groups = [ "synapse-dev" ]
    }
  ]
}

variable "groups" {
  default = [
    {
      name = "synapse-dev"
      policy = "synapse-dev-policy"
    },
  ]
}
