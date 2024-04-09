resource "aws_instance" "resume-app-ec2-instance" {
  ami           = "ami-05adadbbe8cf9fb48"
  instance_type = "t4g.nano"
  subnet_id     = aws_subnet.resume-app-public-subnet.id
  security_groups = [aws_security_group.resume-app-security-group.id]
}

output "ec2_instance_ip" {
  value = aws_instance.resume-app-ec2-instance.public_ip
}