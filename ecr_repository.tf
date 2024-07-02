resource "aws_ecr_repository" "resume-app-ecr-repo" {
  name = "resume-app"

tags = {
    Name = "${var.environment}-${var.ecr_repository_name}"
  }
}
