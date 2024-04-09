resource "aws_subnet" "resume-app-public-subnet" {
  vpc_id               = aws_vpc.resume-app-vpc.id
  cidr_block           = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone    = "us-east-1b"
}
