resource "aws_lb" "resume-app-application-load-balancer" {
  name               = var.resume-app-application-load-balancer-name
  internal           = false
  load_balancer_type = "application"
  subnets            = [aws_subnet.resume-app-public-subnet.id, aws_subnet.resume-app-public-subnet2.id] # Specify 2 subnets at least
}