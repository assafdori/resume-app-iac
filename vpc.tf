resource "aws_vpc" "resume-app-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.environment}-${var.aws_vpc_name}"
  }
}
