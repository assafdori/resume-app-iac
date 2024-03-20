provider "aws" {
  region = "us-east-1"  # Replace with your desired region
}

resource "aws_instance" "web_server" {
  ami           = "ami-0440d3b780d96b29d"  # Replace with your desired AMI ID
  instance_type = "t2.micro"               # Replace with your desired instance type
}