resource "aws_s3_bucket" "terraform_state_bucket" {
  bucket = "resume-app-terraform-state-remote"

  tags = {
    Name = "Terraform State Bucket"
  }
}