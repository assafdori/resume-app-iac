terraform {
  backend "s3" {
    bucket  = "terraform-resume-app-state-remote"
    key     = "terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
