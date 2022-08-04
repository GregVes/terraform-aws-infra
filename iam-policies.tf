# iam full access
resource "aws_iam_policy" "drone" {
  name        = var.groups[0].policy
  path        = "/"
  description = "A policy allowing Drone to perform actions against AWS resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:GetPolicy",
          "iam:GetGroup",
          "iam:GetGroupPolicy",
          "iam:GetUser",
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
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          IpAddress = {
            "aws:SourceIp" = [
              "51.83.179.16/32",
              "51.83.147.42/32"
            ]
          }
        }
      },
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
        ]
        Effect   = "Allow"
        Resource = "arn:aws:s3:::gregentoo-terraform-backend/*"
        Condition = {
          IpAddress = {
            "aws:SourceIp" = [
              "51.83.179.16/32",
              "51.83.147.42/32"
            ]
          }
        }
      },
    ]
  })
}

# this is needed to reference the policy in aws_iam_group_policy_attachment's arn
data "aws_iam_policy" "policy" {
  for_each = { for group in var.groups: group.name => group }
  name = each.value.policy
  depends_on = [
    aws_iam_policy.drone,
  ]
}