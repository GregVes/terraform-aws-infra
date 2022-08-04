variable "users" {
  description = "A list of users objects"
  default = [
    {
      name = "service_drone"
      groups = [ "drone-ci" ]
    }
  ]
}

variable "groups" {
  default = [
    {
      name = "drone-ci"
      policy = "drone-ci-policy"
    },
  ]
}