resource "aws_s3_bucket" "bucket" {
  for_each = toset(var.buckets)

  bucket = each.key
}

resource "aws_s3_bucket_versioning" "bucket_versioning" {
  for_each = toset(var.buckets)

  bucket = aws_s3_bucket.bucket[each.key].id
  versioning_configuration {
    status = "Enabled"
  }
}