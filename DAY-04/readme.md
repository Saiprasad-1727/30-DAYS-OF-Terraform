This blog explains how Terraform manages infrastructure state, why the Terraform state file is critical, and how to configure a secure remote backend using Amazon S3 for team-oriented workflows.

# Purpose of the Terraform State File
Terraform uses a .tfstate file to keep a record of everything it has created. This file stores details such as resource IDs, metadata, and other attributes even sensitive ones.

Before making any changes, Terraform compares what you want (your configuration files) with what currently exists (the state in the .tfstate file).

Terraform does not check the cloud provider directly every time because it would be slower and more expensive. Instead, it relies on the state file as a quick reference to understand the current setup.

# How Terraform Determines Changes
Terraform figures out what needs to be created, updated, or deleted by comparing what you want with what currently exists. It follows a simple three-step process:

It reads your desired state from the .tf files (What you want (from your .tf files).

It reads the current state from the .tfstate file(What currently exists (from the .tfstate file).

It compares both and decides what actions are needed to make them match. These actions may include:

Creating new resources

Updating existing ones

Deleting resources that were removed from the configuration

Example

If your configuration defines 3 resources, but none exist yet, Terraform will create all 3.

If you delete a resource from your .tf files, Terraform will detect that change and remove that resource from the cloud to stay consistent.

## How Terraform Updates Infrastructure: Step-by-Step Explained in Detail
Terraform follows a precise and reliable workflow to update infrastructure. This workflow ensures that your cloud environment always matches what you have defined in your configuration files. The entire process revolves around Terraform’s ability to compare your desired state with the current state and apply only the required changes. Below are the key steps involved, explained in clear and detailed paragraphs.

### Step 1: Terraform Reads Your Desired State

Terraform begins by loading the .tf configuration files you have written. These files describe the resources you want to create or maintain, including their types, properties, sizing, tags, and dependencies. Terraform uses this information to build an internal model of your desired infrastructure. This becomes the “desired state,” which represents how your cloud environment should ideally look after any updates.

### Step 2: Terraform Loads the Current State

Next, Terraform reads the terraform.tfstate file, which acts as its internal database. This state file contains a record of all the resources Terraform previously created, along with their cloud provider–assigned IDs and attributes. By reading this file, Terraform understands what already exists and what values those resources currently hold. Without the state file, Terraform would have no way to map between your logical resource names in configuration and the actual physical resources in the cloud.

### Step 3: Terraform Refreshes the Actual State (If Needed)

Before calculating changes, Terraform may reach out to the cloud provider and refresh the state information. This helps Terraform detect any modifications made outside its control, such as someone manually deleting an EC2 instance from the AWS console or updating a security group rule. By refreshing the actual state, Terraform ensures that it is working with the most accurate, up-to-date details. This step is essential for identifying any configuration drift between what exists and what your configuration expects.

### Step 4: Terraform Compares Desired State with Actual State

Once Terraform has the desired state from your configuration and the actual state from the cloud and state file, it performs a full comparison. This comparison reveals exactly what has changed. Terraform determines whether new resources need to be created, if existing resources must be modified, or if certain resources should be destroyed because they no longer appear in your configuration. Some changes—such as renaming a resource or altering immutable properties—may require destroying and recreating the resource entirely. This comparison is the intelligence behind Terraform’s declarative model.

### Step 5: Terraform Creates an Execution Plan

Based on the comparison, Terraform generates an execution plan. This plan outlines every action Terraform intends to take, categorized as create, update, delete, or replace. The plan is a safety layer that helps you understand the impact of your changes before they are applied. It gives you complete visibility into resource operations, ensuring you are fully aware of the consequences of any configuration modification. Importantly, Terraform does not perform any changes at this stage—it simply informs you of what will happen.

### Step 6: Terraform Applies the Changes

When you approve the plan by running terraform apply, Terraform begins updating your infrastructure. It uses cloud provider APIs to create new resources, update existing ones, or delete those that are no longer required. Terraform performs these actions in a dependency-aware order, ensuring that related resources are updated sequentially and safely. For example, Terraform will not modify a load balancer before updating its target group, and it will not delete a VPC before removing resources dependent on that VPC. This phase is where the actual changes to your cloud environment occur.

### Step 7: Terraform Updates the State File

After all operations succeed, Terraform updates the terraform.tfstate file. This is one of the most critical steps in the process because the state file must reflect the exact condition of your infrastructure after the update. Terraform stores new resource IDs, updated attributes, and revised dependency relationships. This ensures that future plans and applies are accurate and based on the latest infrastructure details. An outdated or missing state file can lead to incorrect operations, which is why managing state securely and reliably is essential.




“Terraform stores its state in a local file by default, but relying on a local state file creates several serious risks for both individuals and teams. One major concern is security: the state file often contains sensitive information such as resource IDs, access details, networking metadata, and sometimes even secrets. If this file is stored on a laptop or personal workspace, it becomes vulnerable to theft, accidental sharing, or unauthorized access. Another challenge is collaboration. Since the state file exists on only one person’s machine, no other team member has visibility into the latest state. This leads to inconsistent environments, conflicting updates, and the possibility of multiple people unknowingly modifying the same resources.”

# Why Local State Files Are a Risk
While Terraform creates the state file locally by default, this introduces several challenges:

#### Security risks: The file contains sensitive cloud metadata.

#### Team collaboration issues: Only one person has access to the latest state.

#### Possibility of corruption: Manual edits or accidental deletion can break Terraform’s ability to track resources.

## This is where remote backends play a pivotal role.

# What Is a Remote Backend?
A remote backend is a centralized, secure location where Terraform stores its state file. Instead of relying on a local .tfstate, Terraform reads and writes the state from a remote storage service.

### Supported Remote Backend Types : 
Terraform supports several cloud storage services for storing remote state, including:

AWS S3

Azure Blob Storage

Google Cloud Storage (GCS)

These backends provide reliable, cloud-based storage for Terraform state files.

Benefits of Using a Remote Backend
Using a remote backend offers multiple advantages, especially in team and production environments:

Team Collaboration
Multiple users can work on the same Terraform environment safely without conflicts.

Centralized and Consistent State Tracking
Everyone accesses the same state file, ensuring accuracy across all deployments.

Secure Storage with Access Controls
State files can be protected using IAM roles, encryption, and policies.

Versioning and Recovery
Remote storage services support state versioning, allowing rollback if corruption or accidental changes occur.

Recommended Backend for AWS Projects
For AWS-based infrastructures, Amazon S3 (often combined with DynamoDB for state locking but now its deprecated) is the most commonly recommended and widely adopted backend due to its durability, security, and ease of integration with Terraform.


”before implementing the hands-on implementation, make sure we need to create a bucket for remote backend”
Hands-On Implementation: From Theory to Practice
Step 1: Configure AWS Credentials (aws configure)
First, you need to let Terraform know how to talk to AWS, and that happens through the AWS CLI credentials.

Make sure AWS CLI is installed.

Run:

PS C:\Users\annam\OneDrive\Desktop\terraform\30-DAYS-OF-Terraform\DAY_04> aws configure
AWS Access Key ID [****************5TOZ]: AKIAVHM3IZRR3CENGR6D
AWS Secret Access Key [****************sbox]: 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
Default region name [us-east-1]: 
Default output format [json]: 
PS C:\Users\annam\OneDrive\Desktop\terraform\30-DAYS-OF-Terraform\DAY_04> 
Provide:

AWS Access Key ID

AWS Secret Access Key

Default region (e.g., us-east-1)

Default output format (e.g., json)

These credentials are stored locally (usually in ~/.aws/credentials) and Terraform uses them via the AWS provider.

Step 2: Create a Terraform Project Folder
Create a working directory for your Terraform project:

mkdir DAY-04
cd Day-04
Inside this folder, you will keep all .tf files (configuration, backend, variables, etc.).

Step 3: Write the Terraform Configuration (main.tf)
Create a main.tf file and define:

Provider block – tells Terraform you’re using AWS and which region.

(Optional but recommended) Backend block – tells Terraform to store state in S3 instead of locally.

One or more resources – what you actually want to create.

Example:

terraform{

# configure the remote backend to use S3
    backend “s3” {
        bucket = “saiprasad-terraform-state-2025”
        key    = “dev/terraform.tfstate”
        region = “us-east-1”
        encrypt = true
        use_lockfile = true
    }
    required_providers {
        aws = {
        source  = “hashicorp/aws”
        version = “~> 6.0”
        }
    }
}

# configure the AWS Provider
provider “aws” {
    region = “us-east-1”
}

# create an S3 bucket
resource “aws_s3_bucket” “first_bucket” {
    bucket = “saiprasad-terraform-bucket-day3-2025”

    tags = {
        name = “my-first-bucket”
        environment = “dev”
    }
  
}
Note: The S3 bucket and DynamoDB table for backend usually need to exist before this, or be created manually/with a separate bootstrap.

### Step 4: Initialize Terraform (terraform init)
Now Terraform needs to:

Download the AWS provider

Configure the backend (S3 in this case)

Prepare the working directory

Run:

PS C:\Users\annam\OneDrive\Desktop\terraform\30-DAYS-OF-Terraform\DAY_04> terraform init
Initializing the backend...
Initializing provider plugins...
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v6.23.0

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running “terraform plan” to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
PS C:\Users\annam\OneDrive\Desktop\terraform\30-DAYS-OF-Terraform\DAY_04>
What happens here:

Terraform reads the terraform and provider blocks.

It downloads the AWS provider plugin.

It configures the S3 backend and, if a local state file exists, asks to migrate it to S3.

After this, Terraform is ready to manage your infrastructure.

Step 5: Preview Changes with terraform plan
Before touching real infrastructure, you always check what Terraform wants to do.

Run:

terraform plan
Terraform will:

Read your .tf files (desired state).

Read the state (from S3 backend or local if you’re not using remote).

Compare desired vs current state.

Show you a plan like:

Plan: 1 to add, 0 to change, 0 to destroy.
No changes are made yet; this is just a dry run.




Step 6: Apply the Changes (terraform apply)
When you are happy with the plan, you actually create the resources.

Run:

terraform apply
Terraform will:

Recreate the plan to ensure nothing changed.

Ask for confirmation: Do you want to perform these actions?

Call AWS APIs to create/update/delete resources.

When done, update the state file in the backend (S3) to match the real infrastructure.

Your infrastructure is now live in AWS.

Step 7: (Optional) Update the Infrastructure
If you change something in main.tf (for example, add another resource or change a setting):

Edit main.tf.

Run:

terraform plan
to see what will change.

Run:

terraform apply
Terraform will only modify what is needed to make reality match your new configuration. Again, it updates the state after successful changes.







Step 8: Destroy the Infrastructure (terraform destroy)
When you no longer need the infrastructure (for example, at the end of a demo or lab), you can safely remove everything Terraform created.

Run:

terraform destroy
Terraform will:

Read configuration + state.

Identify all resources it manages.

Show you a plan of what will be destroyed.

After confirmation, call AWS APIs to delete those resources.

Update the state file to reflect that nothing remains.

After a successful destroy:

Your AWS resources are gone.

The state now reflects an empty infrastructure for that configuration.

## conclusion

As we finish Day 4, I want to pause for a moment and talk to you—not like a trainer teaching technical topics, but like a friend sitting next to you on this 30-day journey.


Terraform uses the state file to remember everything it has created in your cloud. This file helps Terraform understand what already exists and what needs to be added, changed, or removed. Because of this, the state file is very important.

To keep it safe, we should not store it on our laptop or edit it manually. The best way is to save it in a secure remote place like an S3 bucket. This also helps when multiple people are working on the same project.

In short, the Terraform state file is like Terraform’s memory. If we protect it and store it properly, Terraform can manage our cloud infrastructure smoothly and without mistakes.

If you are reading this right now, it means you are already doing something many people find difficult: you are consistently showing up for yourself.

You are not just reading a tutorial. You’re learning alongside someone who is also growing, also figuring things out step by step. And if at any point you feel confused or stuck, trust me—it happens to all of us.

And if you want a clearer, more visual explanation of today’s concepts, I recommend watching the video by PiyushSachdeva. It will definitely help you understand everything more clearly.

video : https://youtu.be/YsEdrl9O5os?si=Ry1MxqtcwBmPJxBB

