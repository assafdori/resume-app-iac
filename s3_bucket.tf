resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "terraform-state-bucket"
  region = var.provider_region

  tags = {
    Name = "Terraform State Bucket"
  }
}