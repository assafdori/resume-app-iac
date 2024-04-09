resource "aws_route_table" "resume-app-public-route-table" {
  vpc_id = aws_vpc.resume-app-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.resume-app-igw.id
  }
}
