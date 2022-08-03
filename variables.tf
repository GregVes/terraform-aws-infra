variable "users" {
  description = "A list of users objects"
  default = [
    {
      name = "service_drone_iam"
      groups = [
        "drone-iam"
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
    }
  ]
}