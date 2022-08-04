output "secret" {
  value = {
    for user in var.users :
    user.name => {
      access_key         = aws_iam_access_key.user_keys[user.name].id,
      encrypted_secret   = aws_iam_access_key.user_keys[user.name].encrypted_secret,
    }
  }
}