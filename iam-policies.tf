resource "aws_iam_policy" "synapse_dev" {
  name        = var.groups[0].policy
  path        = "/"
  description = "A policy allowing Synapse k8s CronJob to store Synapse db backups to AWS S3"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action = var.synapse_dev_s3_actions
        Resource = "${aws_s3_bucket.bucket[var.buckets[0]].arn}/*"
        Condition = {
          IpAddress = {
            "aws:SourceIp" = var.cluster_cidr_ranges
          }
        }
      }
    ]
  })
}

# this is needed to reference the policy in aws_iam_group_policy_attachment's arn
data "aws_iam_policy" "policy" {
  for_each = { for group in var.groups: group.name => group }
  name = each.value.policy
  depends_on = [
    aws_iam_policy.synapse_dev
  ]
}