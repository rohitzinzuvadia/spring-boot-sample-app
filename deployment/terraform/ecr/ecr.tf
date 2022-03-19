terraform {
  backend "s3" {
    bucket = "dev.rdz3138.test"
    key    = "terraform-test/ecr"
    region = "ap-south-1"
  }
}
provider "aws" {
  region = "ap-south-1"
}

resource "aws_ecr_repository" "spring-boot-sample-app-ecr" {
  name = "spring-boot-sample-app"
}
output "ecr_repository_name" {
    description = "ECR Repository url"
    value = aws_ecr_repository.spring-boot-sample-app-ecr.repository_url
}