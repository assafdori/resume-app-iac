# Specify the provider and region
provider "aws" {
  region = "your-aws-region"
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
  availability_zone    = var.your_availability_zone
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
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.your_ip_address] # Limit SSH access to your IP address
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create IAM role for ECS task execution
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs-task-execution-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

# Attach IAM policy for ECS task execution
resource "aws_iam_policy_attachment" "ecs_task_execution_attachment" {
  name       = "ecs-task-execution-policy-attachment"
  roles      = [aws_iam_role.ecs_task_execution_role.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# Create ECR repository
resource "aws_ecr_repository" "my_ecr_repo" {
  name = "my-ecr-repo"
}

# Create ECS cluster
resource "aws_ecs_cluster" "my_ecs_cluster" {
  name = "my-ecs-cluster"
}

# Create ECS task definition
resource "aws_ecs_task_definition" "my_task_definition" {
  family                   = "my-task"
  cpu                      = 256 # CPU units (0.25 vCPU)
  memory                   = 512 # Memory in MiB
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]

  container_definitions = jsonencode([
    {
      name      = "my-container"
      image     = "your-ecr-repo-url:latest" # URL of your Docker image in ECR
      cpu       = 256
      memory    = 512
      essential = true
    }
  ])
}

# Create ECS service
resource "aws_ecs_service" "my_ecs_service" {
  name            = "my-ecs-service"
  cluster         = aws_ecs_cluster.my_ecs_cluster.id
  task_definition = aws_ecs_task_definition.my_task_definition.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.public_subnet.id]
    security_groups  = [aws_security_group.my_security_group.id]
    assign_public_ip = true
  }
}

