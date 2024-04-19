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

resource "aws_lb_target_group" "node-exporter-target-group" {
  name     = "node-exporter-target-group"
  port     = 9100  # Port on which Node Exporter listens for metrics
  protocol = "HTTP"  # Assuming Node Exporter serves metrics over HTTP
  vpc_id   = aws_vpc.resume-app-vpc.id

  health_check {
    path                = "/metrics"  # Endpoint path for Node Exporter metrics
    port                = 9100  # Port on which Node Exporter listens for metrics
    protocol            = "HTTP"  # Protocol for health checks
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
