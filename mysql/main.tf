# ---------------------------------------------------------------------------------------------------------------------
# A SIMPLE EXAMPLE OF HOW TO DEPLOY MYSQL ON RDS
# This is an example of how to use Terraform to deploy a MySQL database on Amazon RDS.
#
# Note: This code is meant solely as a simple demonstration of how to lay out your files and folders with Terragrunt
# in a way that keeps your Terraform code DRY. This is not production-ready code, so use at your own risk.
# ---------------------------------------------------------------------------------------------------------------------

terraform {
  # Live modules pin exact Terraform version; generic modules let consumers pin the version.
  # The latest version of Terragrunt (v0.36.0 and above) recommends Terraform 1.1.4 or above.
  required_version = ">= 1.1.4"

  # Live modules pin exact provider version; generic modules let consumers pin the version.
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 3.7.0"
    }
  }
}


# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE DB SUBNET GROUP 
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_db_subnet_group" "demo" {
  name       = "terragrunt-demo-subnet-group"
  subnet_ids = ["10.0.0.0/24","10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}




# ---------------------------------------------------------------------------------------------------------------------
# CREATE THE MYSQL DB
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_db_instance" "mysql" {
  engine         = "mysql"
  engine_version = "8.0.31"
  db_subnet_group_name = aws_db_subnet_group.demo.name

  db_name     = var.db_name
  username = var.master_username
  password = var.master_password

  instance_class    = var.instance_class
  allocated_storage = var.allocated_storage
  storage_type      = var.storage_type

  # TODO: DO NOT COPY THIS SETTING INTO YOUR PRODUCTION DBS. It's only here to make testing this code easier!
  skip_final_snapshot = true
}
