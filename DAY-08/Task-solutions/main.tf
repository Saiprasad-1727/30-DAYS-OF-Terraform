resource "aws_s3_bucket" "my-buckets" {
  count = length(var.bucket_names)
  bucket   = var.bucket_names[count.index]

  tags = var.tags
  
}

resource "aws_s3_bucket" "buckets-for-each" {
  for_each = toset(var.bucket_names_for_each)
  bucket   = each.key

  tags = var.tags
  
}