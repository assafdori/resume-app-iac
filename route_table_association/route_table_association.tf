resource "aws_route_table_association" "resume-app-public-subnet-association" {
  subnet_id      = aws_subnet.resume-app-public-subnet.id
  route_table_id = aws_route_table.resume-app-public-route-table.id
}
