variable "domain_name" {
  description = "The domain name of the main web application."
  default     = "assafdori.com"
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

variable "cidr_egress_ips" {
  description = "Defines to which IPs outbound traffic is allowed."
  default     = ["0.0.0.0/0"]
}

variable "cidr_egress_protocol" {
  description = "Defines which protocols are allowed for outbound traffic."
  default     = "-1"
}

variable "aws_ami" {
  description = "Defines which AMI is used for the host server of web application."
  default     = "ami-07b3a3a3ddede3183"
}