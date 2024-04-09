# Import other Terraform configuration files
terraform {
  required_version = ">= 0.13"
}

# Provider configuration
provider "aws" {
  region = "us-east-1"
}

# Calling for Terraform configurations from different .tf files ##

# VPC
module "vpc" {
  source = "./vpc"
}

# Subnet
module "subnet" {
  source = "./subnet"
}

# Internet Gateway
module "internet_gateway" {
  source = "./internet_gateway"
}

# Route Table
module "route_table" {
  source = "./route_table"
}

# Route Table Association
module "route_table_association" {
  source = "./route_table_association"
}

# Security Group
module "security_group" {
  source = "./security_group"
}

# EC2 Instance
module "ec2_instance" {
  source = "./ec2_instance"
}

# ECR Repository
module "ecr_repository" {
  source = "./ecr_repository"
}

# DNS Configuration
module "dns" {
  source = "./dns.tf"
}