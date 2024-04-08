# Specify the provider and region
provider "aws" {
  region = "us-east-1"
}

# Create VPC
resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Create public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id               = aws_vpc.my_vpc.id
  cidr_block           = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone    = "us-east-1b"
}

# Create internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

# Create route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

# Associate subnet with route table
resource "aws_route_table_association" "public_subnet_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}

# Create security group
resource "aws_security_group" "my_security_group" {
  name        = "my-security-group"
  description = "Allow HTTP and SSH traffic"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows all IPs to HTTP
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows all IPs to SSH
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create EC2 instance
resource "aws_instance" "my_ec2_instance" {
  ami           = "ami-051f8a213df8bc089" # Specify your AMI ID
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.my_security_group.id]

  # You can customize the EC2 instance as per your requirements
  # For example:
  # key_name      = "my-keypair"
  # iam_instance_profile = "my-ec2-role"
}

# Use existing ECR repository
data "aws_ecr_repository" "my_ecr_repo" {
  name = "cli-resume" # Specify the name of your ECR repository
}

