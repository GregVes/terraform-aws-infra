resource "aws_iam_user" "user" {
  for_each = { for user in var.users: user.name => user }

  name = each.value.name
}

resource "aws_iam_access_key" "user_keys" {
  for_each = { for user in var.users: user.name => user }

  user = each.value.name
  depends_on = [
    aws_iam_user.user
  ]
  # gpg --export <email> |base64
  pgp_key = "mDMEYupyuhYJKwYBBAHaRw8BAQdAzcBIlTLgwlpKw405mFc92on60Ynqn3jOEzNlOx+/rKu0KnRlcnJhZm9ybS1rZXkgPHZlc3Bhc2llbmdyZWdvcnlAZ21haWwuY29tPoiZBBMWCgBBFiEEKAhSAkASkG0X7zl1ZGxhMmczAs4FAmLqcroCGwMFCQPCZwAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQZGxhMmczAs4pAwD8D4QJm0hvJTuynKTgWGIpS7igd/KUR3SUifWIB+fmLMAA/3ylnuBVzQySsYD4l4XxmfB5ccQ65AtlJ94vtg3FHFoNuDgEYupyuhIKKwYBBAGXVQEFAQEHQN8cbxRN5WREAx0JfNNT+j/a7IBWscWFsrL8WiA22mMvAwEIB4h+BBgWCgAmFiEEKAhSAkASkG0X7zl1ZGxhMmczAs4FAmLqcroCGwwFCQPCZwAACgkQZGxhMmczAs4DugD/UflmRnuLORRPkD8hXM8iMJ2ATCnWmHCn/xsYXzSnprsA/2Nw/eKWbkR2kpFcpRdQuydj4ZUKFNolZ8BFptHtxp4O"
}

resource "aws_iam_user_group_membership" "group_membership" {
  for_each = { for user in var.users: user.name => user }

  user = each.value.name
  groups = each.value.groups
  depends_on = [
    aws_iam_group.group
  ]
}