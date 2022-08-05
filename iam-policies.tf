resource "aws_iam_policy" "drone" {
  name        = var.groups[0].policy
  path        = "/"
  description = "A policy allowing Drone to perform actions against AWS resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action = var.drone_iam_actions
        Resource = "*"
        Condition = {
          IpAddress = {
            "aws:SourceIp" = var.drone_cidr_ranges
          }
        }
      },
      {
        Action = var.drone_s3_state_bucket_action
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.state_backend_bucket}"
        Condition = {
          IpAddress = {
            "aws:SourceIp" = var.drone_cidr_ranges
          }
        }
      },
      {
        Action = var.s3_object_actions
        Effect   = "Allow"
        Resource = "arn:aws:s3:::${var.state_backend_bucket}/${var.state_backend_object}"
        Condition = {
          IpAddress = {
            "aws:SourceIp" = var.drone_cidr_ranges
          }
        }
      },
      {
        Action = var.drone_s3_buckets_actions
        Effect   = "Allow"
        Resource = "*"
        Condition = {
          IpAddress = {
            "aws:SourceIp" = var.drone_cidr_ranges
          }
        }
      },
    ]
  })
}

resource "aws_iam_policy" "synapse_dev" {
  name        = var.groups[1].policy
  path        = "/"
  description = "A policy allowing Synapse k8s CronJob to store Synapse db backups to AWS S3"

  policy = jsonencode({
    Sid = "SynapseDevDbBackupPolicy"
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action = var.s3_object_actions
        Resource = "${aws_s3_bucket.bucket[var.buckets[0]].arn}/*"
        Condition = {
          IpAddress = {
            "aws:SourceIp" = var.drone_cidr_ranges
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
    aws_iam_policy.drone,
    aws_iam_policy.synapse_dev
  ]
}