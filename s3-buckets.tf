resource "aws_s3_bucket" "bucket" {
  for_each = toset(var.buckets)

  bucket = each.key

  tags = {
    managed_by = "Terraform"
  }
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  for_each = toset(var.buckets)

  bucket = aws_s3_bucket.bucket[each.key].id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "bucket_encryption" {
  for_each = toset(var.buckets)

  bucket = each.key

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "AES256"
    }
  }
}