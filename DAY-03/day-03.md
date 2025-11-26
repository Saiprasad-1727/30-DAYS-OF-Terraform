## Infrastructure as Code (IaC) - creating an VPC & S3 bucket(AWS Service) using Terraform🚀 Day -2 of my #30DaysOfAWSTerraform Challenge! 🚀

Creating cloud resources manually from the AWS Management Console is fine for beginners, but it quickly becomes inefficient as environments grow. This is where Infrastructure as Code (IaC) tools like Terraform shine. Terraform allows you to define, version, and deploy infrastructure programmatically — improving consistency, repeatability, and automation.

In this blog, we will walk through a simple yet essential example:

Creating an Amazon S3 bucket using Terraform.

Why Terraform for AWS S3?

Amazon S3 is one of the most widely used services for storing application logs, static website files, backups, and documents.

Instead of manually clicking through the AWS Console, Terraform enables you to:

Create and destroy S3 buckets on demand

Version and track infrastructure changes using Git

Replicate the same setup in Dev, QA, and Production

Enforce consistency and automate deployments

This guide covers everything from the folder structure to executing the commands.

Prerequisites

Before you proceed, ensure you have:

Terraform installed (v1.x+)

An AWS account

AWS CLI configured with credentials

(aws configure OR stored in ~/.aws/credentials)

Basic understanding of AWS and IaC concepts (optional but helpful)



Step 1 : Create a Working Directory

Create a folder for your Terraform project:

mkdir DAY-03

cd DAY-03

Step 2: Create the Terraform Configuration File

Create a file named main.tf and add the following code:

# Step 1: Configure the AWS Provider

terraform {
  required_providers {
    aws = {
      source = “hashicorp/aws”
      version = “6.22.1”
    }
  }
}

provider “aws” {
  region = “us-east-1”
}

# Step 2: Create an S3 Bucket
resource “aws_s3_bucket” “my_bucket” {
  bucket = “my-unique-bucket-12345”
  acl    = “private”
}


Explanation of the Code

provider “aws”: Tells Terraform to use AWS as the cloud provider.

region: Where the bucket will be created.

resource “aws_s3_bucket”: Creates an S3 bucket resource.

bucket: Must be globally unique across all AWS accounts.

acl: Defines access control; defaults to private, which is secure.

Step 3: Initialize Terraform

Run the following command:

terraform init

This downloads the AWS provider plugin and prepares the working directory.

Step 4: Validate & Preview the Changes

terraform plan

This command shows what Terraform will create — very useful for verifying your configuration before deployment.

Step 5: Apply the Configuration (Create the S3 Bucket)

terraform apply

Type yes when prompted.

Terraform will now create your S3 bucket in AWS.

You can verify it by opening the AWS Console → S3 → Searching for your bucket name.📺 Video Reference

Here’s the tutorial that helped me build my first Terraform resource:

(1622) 3/30 - Create an AWS S3 Bucket Using Terraform (it’s simple) - YouTube

🚀 Conclusion: A Strong Step Forward

Today’s session was about more than just provisioning a VPC and an S3 bucket. It reinforced several core IaC principles:

Infrastructure can be repeatedly created with consistent results

Terraform intelligently interprets relationships between resources

Implicit dependencies make configurations clean and scalable

Proper authentication and setup form the foundation of any Terraform workflow

This hands-on experience deepened my understanding of Terraform’s workflow and made the learning process much more meaningful.
