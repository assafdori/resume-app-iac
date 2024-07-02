resource "aws_internet_gateway" "resume-app-igw" {
  vpc_id = aws_vpc.resume-app-vpc.id

  tags = {
    Name = "${var.environment}-${var.aws_internet_gateway_name}"
  }

}
