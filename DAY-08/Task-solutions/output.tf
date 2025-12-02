output "count_bucket_names" {
value = [for b in aws_s3_bucket.my-buckets : b.bucket]
description = "All bucket names created with count"
}


output "for_each_bucket_ids" {
value = { for k, r in aws_s3_bucket.buckets-for-each : k => r.id }
description = "Map of bucket name => bucket id for for_each-created buckets"
}