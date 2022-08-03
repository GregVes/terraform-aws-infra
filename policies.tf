# policies
resource "aws_iam_policy" "iam_full_access" {
  name        = var.groups[0].policy
  path        = "/"
  description = "A policy allowing full access on IAM resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "iam:*",
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
    ]
  })
}

# this is needed to reference the policy in aws_iam_group_policy_attachment's arn
data "aws_iam_policy" "policy" {
  for_each = { for group in var.groups: group.name => group }
  name = each.value.policy
  depends_on = [
    aws_iam_policy.iam_full_access
  ]
}