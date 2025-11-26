terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.22.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

# Step : Create an S3 Bucket
resource "aws_s3_bucket" "my_bucket" {
  bucket = "saiprasad-terraform-bucket-2025"

}

