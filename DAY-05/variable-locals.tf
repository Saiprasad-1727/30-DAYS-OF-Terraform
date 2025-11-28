variable "environment" {
  description = "The environment for the resources"
  default     = "dev" 
}
variable "my_name" {
  description = "Your name to be used in resource naming"
  default     = "saiprasad"
}
variable "region" {
  description = "The AWS region to deploy resources in"
  default     = "us-east-1"
}

locals {
  bucket_name = "${var.my_name}-bucket-${var.environment}-${var.region}"
  vpc_name   = "${var.my_name}-vpc-${var.environment}"
}