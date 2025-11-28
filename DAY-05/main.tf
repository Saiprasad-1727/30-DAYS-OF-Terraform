# create an S3 bucket
resource "aws_s3_bucket" "first_bucket" {
    bucket = local.bucket_name

    tags = {
        name = local.bucket_name
        environment = var.environment
    }
  
}

# create a VPC
resource "aws_vpc" "first_vpc" {
    cidr_block = "10.0.0.0/16"
    region = var.region
    tags = {
        Name = local.vpc_name
        environment = var.environment
    }
  
}

# create an Ec2 instance
resource "aws_instance" "first_instance" {
    ami           = "ami-0c02fb55956c7d316" # Amazon Linux 2 AMI
    instance_type = "t2.micro"
    region = var.region
    tags = {
        Name = "${var.my_name}-instance-${var.environment}"
        environment = var.environment
    }
}