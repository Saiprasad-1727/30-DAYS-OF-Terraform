resource "aws_s3_bucket" "bucket1" {
    # bucket = "my-unique-bucket-day08" # Ensure this bucket name is globally unique
    count = 2
    bucket = var.bucket_names[count.index]

    tags = var.tags
  
}

resource "aws_s3_bucket" "bucket2" {
    
    for_each = var.bucket_names_set #2
    bucket = each.key

    tags = var.tags
  depends_on = [ aws_s3_bucket.bucket1 ]
}