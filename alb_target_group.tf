resource "aws_lb_target_group" "resume-app-application-load-balancer-target-group" {
  name     = var.resume-app-application-load-balancer-target-group-name
  port     = 80 # Port on which EC2 instance listens
  protocol = "HTTP"
  vpc_id   = aws_vpc.resume-app-vpc.id

  health_check {
    path                = "/"
    port                = 80
    protocol            = "HTTP"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}