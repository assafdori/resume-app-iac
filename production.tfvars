domain_name = "assafdori.com"
environment = "prod"
wildcard_domain_name = "*.assafdori.com"
instance_name = "resume-app-server"
provider_region = "us-east-1"
security_group_name = "resume-app-security-group"
cidr_ingress_80 = ["0.0.0.0/0"]
cidr_ingress_443 = ["0.0.0.0/0"]
cidr_ingress_22 = ["0.0.0.0/0"]
cidr_ingress_icmp = ["0.0.0.0/0"]
cidr_ingress_node_exporter = ["0.0.0.0/0"]
cidr_ingress_prometheus = ["0.0.0.0/0"]
cidr_ingress_grafana = ["0.0.0.0/0"]
cidr_ingress_alertmanager = ["0.0.0.0/0"]
cidr_egress_ips = ["0.0.0.0/0"]
cidr_egress_protocol = "-1"
aws_ami = "ami-0e90165acf703dc49"
aws_instance_type = "t4g.micro"
aws_key_pair = "ssh-key-resume-server"
resume-app-application-load-balancer-name = "load-balancer"
resume-app-application-load-balancer-target-group-name = "load-balancer-target-group"
aws_certificate_name = "resume-app-ssl-cert"
aws_vpc_name = "resume-app-vpc"
aws_public_subnet_name = "public-subnet"
aws_public_subnet_name2 = "public-subnet2"