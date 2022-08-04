variable "drone_cidr_ranges" {
  description = "CIDR ranges where drone instance is located"
  default = [
    "51.83.179.16/32",
    "51.83.147.42/32"
  ]
}

variable "drone_iam_actions" {
  description = "List of IAM actions Drone is allowed to perform"
  default = [
    "iam:GetPolicy",
    "iam:GetGroup",
    "iam:GetGroupPolicy",
    "iam:GetPolicyVersion",
    "iam:GetUser",
    "iam:ListAccessKeys",
    "am:ListAttachedGroupPolicies ",
    "iam:ListGroupsForUser",
    "iam:ListPolicies",
    "iam:AddUserToGroup",
    "iam:AttachGroupPolicy",
    "iam:CreateAccessKey",
    "iam:CreateGroup",
    "iam:CreatePolicy",
    "iam:CreateUser",
    "iam:DeleteAccessKey",
    "iam:DeleteGroupPolicy",
    "iam:DeletePolicy",
    "iam:DetachGroupPolicy",
    "iam:PutGroupPolicy",
    "iam:RemoveUserFromGroup",
    "iam:UpdateGroup",
    "iam:UpdateUser",
  ]
}

variable "drone_s3_state_bucket_action" {
  description = "List action for Terraform backend bucket"
  default = [
    "s3:ListBucket"
  ]
}

variable "drone_s3_state_object_actions" {
  description = "List action for Terraform backend object"
  default = [
    "s3:GetObject",
    "s3:PutObject",
    "s3:DeleteObject",
  ]
}

variable "state_backend_bucket" {
  description = "Name of the bucket where terraform state file is located"
  default = "gregentoo-tf-state-backend"
}

variable "state_backend_object" {
  description = "Name of terraform state filed"
  default = "tf-aws-infra.tfstate"
}

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