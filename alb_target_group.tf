resource "aws_lb_target_group" "resume-app-application-load-balancer-target-group" {
  name     = var.resume-app-application-load-balancer-target-group-name
  port     = 80 # Port on which EC2 instance listens
  protocol = "HTTP"
  vpc_id   = aws_vpc.resume-app-vpc.id

  health_check {
    path                = "/"
    port                = "traffic-port"
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
    port                = "traffic-port"  # Using traffic port for consistency, it equals above port
    protocol            = "HTTP"  # Protocol for health checks
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "prometheus-target-group" {
  name     = "prometheus-target-group"
  port     = 9090  # Port on which Prometheus operates
  protocol = "HTTP" 
  vpc_id   = aws_vpc.resume-app-vpc.id

  health_check {
    path                = "/-/healthy"  # Endpoint path for Prometheus health checks
    port                = "traffic-port"  # Using traffic port for consistency, it equals above port
    protocol            = "HTTP"  # Protocol for health checks
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "grafana-target-group" {
  name     = "grafana-target-group"
  port     = 3000  # Port on which Grafana operates
  protocol = "HTTP" 
  vpc_id   = aws_vpc.resume-app-vpc.id

  health_check {
    path                = "/api/health"  # Endpoint path for Grafana health checks
    port                = "traffic-port"  # Using traffic port for consistency, it equals above port
    protocol            = "HTTP"  # Protocol for health checks
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group" "alertmanager-target-group" {
  name     = "alertmanager-target-group"
  port     = 9093  # Port on which Alertmanager operates
  protocol = "HTTP"
  vpc_id   = aws_vpc.resume-app-vpc.id

  health_check {
    path                = "/-/healthy"  # Endpoint path for Alertmanager health checks
    port                = "traffic-port" # Using traffic port for consistency, it equals above port
    protocol            = "HTTP"  # Protocol for health checks
    interval            = 30
    timeout             = 10
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}
