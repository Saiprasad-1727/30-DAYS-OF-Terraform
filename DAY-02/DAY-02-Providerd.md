      version = "~> 5.0"
    }
  }
}
This means:

Use AWS provider version >= 5.0.0 but < 6.0.0.

Allows patch updates like 5.0.1, 5.1.0.

Configuration Examples
Terraform allows you to define provider versions and configurations in your terraform block. Here are some practical examples:

✅ Basic Provider Configuration

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}
Explanation:

Specifies the AWS provider from HashiCorp.

Ensures version 5.0 or higher.

Sets the region to us-east-1.

✅ Multiple Provider Versions

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.1"
    }
  }
}
Explanation:

Uses AWS provider version 5.x (safe upgrades within major version).

Adds random provider for generating random values.

✅ Locking Provider Versions

terraform providers lock
This creates a .terraform.lock.hcl file to ensure consistent versions across environments.
