resource "aws_instance" "resume-app-ec2-instance" {
  ami             = var.aws_ami # This is a custom AMI. ARM platform with Docker pre-installed.
  instance_type   = "t4g.micro"
  security_groups = [aws_security_group.resume-app-security-group.id]
  subnet_id       = aws_subnet.resume-app-public-subnet.id
  key_name        = "ssh-key-resume-server"

  tags = {
    Name = var.instance_name
  }
}