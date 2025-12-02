variable "aws_region" {
    type        = string
    description = "The AWS region to deploy resources in"
    default     = "us-east-1"
}

variable "tags" {
    type = map(string)
    description = "map of tags to assign to resources"  
#     #default = {
#         Environment = "dev"
#         Name        = "dev-Instance"
#         created_by  = "terraform"   
#         }
}

variable "bucket_names" {
    type = list(string)
    description = "List of S3 bucket names to create"
    #default = ["my-unique-bucket-saiprasad-001", "my-unique-bucket-saiprasad-002"]
}

variable "bucket_names_set" {
    type = set(string)
    description = "List of S3 bucket names to create"
   # default = ["my-unique-bucket-saiprasad-003", "my-unique-bucket-saiprasad-004"]
}