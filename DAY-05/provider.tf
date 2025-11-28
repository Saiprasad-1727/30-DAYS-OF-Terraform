terraform{

# configure the remote backend to use S3 jPYq28LVS/Q0/19fN0ehu4iD2fXnD3Vj3UN246Dr
  #  backend "s3" {
  #    bucket = "saiprasad-terraform-state-2025"
   #    key    = "dev/terraform.tfstate"
   #    region = "us-east-1"
     #   encrypt = true
    #    use_lockfile = true
   # }
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 6.0"
        }
    }
}

# configure the AWS Provider
provider "aws" {
    region = "us-east-1"
}