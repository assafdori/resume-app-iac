resource "aws_instance" "resume-app-ec2-instance" {
  ami           = "ami-051f8a213df8bc089"
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.resume-app-public-subnet.id
  security_groups = [aws_security_group.resume-app-security-group.id]
}

output "ec2_instance_ip" {
  value = aws_instance.resume-app-ec2-instance.public_ip
}