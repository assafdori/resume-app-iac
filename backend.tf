terraform {
  backend "s3" {
    bucket  = "resume-app-terraform-state-remote"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
