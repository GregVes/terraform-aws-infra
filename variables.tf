variable "users" {
  description = "A list of users objects"
  default = [
    {
      name = "service_drone_iam"
      groups = [
        "drone-iam"
      ]
    },
    {
      name = "service_drone_s3"
      groups = [
        "drone-s3"
      ]
    }
  ]
}

variable "groups" {
  description = "IAM user groups"
  default = [
    {
      name = "drone-iam"
      policy = "iam-policy-full-access"
    },
    {
      name = "drone-s3"
      policy = "s3-policy-creation"
    }
  ]
}