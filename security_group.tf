resource "aws_security_group" "resume-app-security-group" {
  name        = var.security_group_name
  description = "Allow HTTP and HTTPS traffic for inbound and outbound connections to the web app."
  vpc_id      = aws_vpc.resume-app-vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.cidr_ingress_80
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = var.cidr_ingress_443
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_ingress_22
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = var.cidr_ingress_icmp
  }

  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = var.cidr_ingress_node_exporter
  }

    ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = var.cidr_ingress_prometheus
  }

    ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = var.cidr_ingress_grafana
  }

    ingress {
    from_port   = 9093
    to_port     = 9093
    protocol    = "tcp"
    cidr_blocks = var.cidr_ingress_alertmanager
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = var.cidr_egress_protocol
    cidr_blocks = var.cidr_egress_ips
  }
}