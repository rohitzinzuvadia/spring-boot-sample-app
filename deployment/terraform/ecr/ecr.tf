terraform {
  backend "S3" {
      region = "ap-south-1"
  }
}
provider "aws" {
  region = "ap-south-1"
}

resource "aws_ecr_repository" "spring-boot-sample-app-ecr" {
  name = "spring-boot-sample-app"
}
output "repository_url" {
    description = "ECR Repository url"
    value = aws_ecr_repository.spring-boot-sample-app-ecr.repository_url
}