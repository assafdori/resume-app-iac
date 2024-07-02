variable "domain_name" {
  description = "The domain name of the main web application."
  default     = "assafdori.com"
}

variable "environment" {
  description = "The environment in which to deploy, production or development."
  default     = "production"
}

variable "wildcard_domain_name" {
  description = "The wild card domain name."
  default = "*.assafdori.com"  
}

variable "instance_name" {
  description = "The EC2 instance name of the main web application."
  default     = "resume-app-server"
}

variable "provider_region" {
  description = "The region in which to setup provider region."
  default     = "us-east-1"
}

variable "security_group_name" {
  description = "The name which the security group will be called."
  default     = "resume-app-security-group"
}

variable "cidr_ingress_80" {
  description = "Defines which IPs are allowed to access via HTTP 80."
  default     = ["0.0.0.0/0"]
}

variable "cidr_ingress_443" {
  description = "Defines which IPs are allowed to access via HTTPS 443."
  default     = ["0.0.0.0/0"]
}

variable "cidr_ingress_22" {
  description = "Defines which IPs are allowed to access via SSH 22."
  default     = ["0.0.0.0/0"]
}

variable "cidr_ingress_icmp" {
  description = "Defines to which IPs are allowed to access via ICMP."
  default     = ["0.0.0.0/0"]
}

variable "cidr_ingress_node_exporter" {
  description = "Defines which IPs are allowed to access via 9100."
  default     = ["0.0.0.0/0"]
}

variable "cidr_ingress_prometheus" {
  description = "Defines which IPs are allowed to access via 9100."
  default     = ["0.0.0.0/0"]
}

variable "cidr_ingress_grafana" {
  description = "Defines which IPs are allowed to access via 9100."
  default     = ["0.0.0.0/0"]
}

variable "cidr_ingress_alertmanager" {
  description = "Defines which IPs are allowed to access via 9100."
  default     = ["0.0.0.0/0"]
}

variable "cidr_egress_ips" {
  description = "Defines to which IPs outbound traffic is allowed."
  default     = ["0.0.0.0/0"]
}

variable "cidr_egress_protocol" {
  description = "Defines which protocols are allowed for outbound traffic."
  default     = "-1"
}

variable "aws_ami" {
  description = "Defines which AMI is used for the EC2 host server of web application."
  default     = "ami-0e90165acf703dc49"
}

variable "aws_instance_type" {
  description = "Defines which instance type is used for the EC2 host server of web application."
  default     = "t4g.micro"
  
}

variable "aws_key_pair" {
  description = "Defines which key pair is used for the EC2 host server of web application."
  default     = "ssh-key-resume-server"
}

variable "aws_vpc_name" {
  description = "Defines which VPC is used for the EC2 host server of web application."
  default     = "resume-app-vpc"
  
}

variable "resume-app-application-load-balancer-name" {
  description = "Defines the resource name for the application load balancer."
  default = "loadbalancer"
}

variable "resume-app-application-load-balancer-target-group-name" {
  description = "Defines the resource name for the application load balancer target group."
  default = "resume-app-load-balancer-target"
}

variable "aws_certificate_name" {
  description = "Defines the resource name for the certificate."
  default = "resume-app-ssl-cert"
  
}

variable "aws_public_subnet_name" {
  description = "Defines the resource name for the public subnet."
  default = "public-subnet"
}

variable "aws_public_subnet_name2" {
  description = "Defines the resource name for the public subnet."
  default = "public-subnet2"
}

variable "ecr_repository_name" {
  description = "Defines the resource name for the ecr repository."
  default = "resume-app-ecr-repo"
}

variable "aws_internet_gateway_name" {
  description = "Defines the resource name for the internet gateway."
  default = "resume-app-igw"
}
