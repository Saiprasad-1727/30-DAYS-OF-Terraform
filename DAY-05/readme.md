# Terraform Variables – Complete Guide

## Overview

Variables are a fundamental part of writing scalable, reusable, and production-ready Infrastructure as Code (IaC) with Terraform. They allow you to avoid hardcoding values, simplify updates, and maintain clean configurations across all environments.

This README provides a complete explanation of:

* What variables are
* Why they are needed
* Types of Terraform variables
* How Terraform decides which variable value to use (precedence)
* Benefits of using variables
* Best practices for production-grade Terraform code

---

## What is a Variable?

A **variable** is simply a container that stores information so you can use it anywhere in your configuration. Instead of writing the same value multiple times, you declare it once and reference it by name.

### Why We Need Variables

* Avoid repeating values
* Improve readability
* Make configuration easier to update
* Keep code DRY (Don’t Repeat Yourself)
* Manage configurations more efficiently

Updating a value in one place updates it everywhere the variable is used.

---

## What Are Variables in Terraform?

Terraform variables allow you to customize your infrastructure **without changing your main configuration files**.

Instead of hardcoding:

* instance types
* region names
* CIDR blocks
* tags
* environment names

You declare them once as variables and reuse them.

### How Variables Improve IaC

* Greater flexibility
* More reusable configurations
* Better maintainability
* Easier multi-environment deployments (dev, stage, prod)

---

## Types of Variables in Terraform

Terraform provides **three main variable types**, each serving a different purpose.

### 1. Input Variables

**Purpose:** Pass values into Terraform modules or root configurations.

Used for:

* AMI IDs
* Region names
* VPC/Subnet CIDR blocks
* Instance sizes
* Environment names

These make your code more dynamic and customizable.

---

### 2. Output Variables

**Purpose:** Expose information from your Terraform configuration.

Outputs are useful for:

* Displaying resource details (IP, ARN, DNS)
* Passing values between modules
* Feeding values into CI/CD pipelines
* Debugging

---

### 3. Local Values (locals)

**Purpose:** Store internal or computed values.

Locals help:

* Avoid repeating expressions
* Simplify logic
* Clean up complex configurations

Example: computing a name prefix, concatenation, or reusable expression.

---

## Terraform Variable Precedence (Highest → Lowest)

When a variable is defined in multiple places, Terraform determines its final value using this order:

### 1. Environment Variables (Highest)

Variables prefixed with `TF_VAR_` override all other sources.

Example:

```
export TF_VAR_region=us-west-1
```

### 2. Command-Line Flags

```
terraform apply -var="region=us-west-2"
```

### 3. Variable Definition Files (.tfvars / auto.tfvars)

Terraform automatically loads:

* `terraform.tfvars`
* `terraform.tfvars.json`
* `*.auto.tfvars`

Custom file example:

```
terraform apply -var-file="prod.tfvars"
```

### 4. Default Values in Variable Blocks (Lowest)

If no other value is found, Terraform uses the default.

Example:

```
variable "region" {
  type        = string
  default     = "us-east-1"
  description = "AWS region to deploy resources"
}
```

---

## Benefits of Using Variables in Terraform

Using variables provides significant advantages:

* Clean and organized configuration files
* No hardcoding values
* Easy multi-environment support
* Enhanced readability
* Reduced mistakes
* Dynamic values during runtime
* Better handling of sensitive data
* Standardized inputs for teams
* Improved scalability and maintainability

---

## Conclusion

Understanding Terraform variable types is essential for writing **clean, modular, and production-ready IaC**.

With proper use of variables, you improve:

* Code quality
* Reusability
* Team collaboration
* Multi-environment consistency

Terraform’s variable precedence system ensures predictable deployments and prevents misconfigurations across dev, stage, and production.

Mastering variables is a core skill for every DevOps engineer building modern, scalable cloud automation.

If you're learning Terraform step-by-step, remember: confusion is normal. Keep going — the clarity comes with practice.
