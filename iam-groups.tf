resource "aws_iam_group" "group" {
  for_each = { for group in var.groups: group.name => group }
  name = each.value.name
}

resource "aws_iam_group_policy_attachment" "group_policy" {
  for_each = { for group in var.groups: group.name => group }
  group = each.value.name
  policy_arn = data.aws_iam_policy.policy[each.key].arn
}