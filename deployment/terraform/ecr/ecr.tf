terraform {
  backend "s3" {
    bucket = "dev.rdz3138.test"
    key    = "terraform-test/ecr"
    region = "${var.regionName}"
  }
}
provider "aws" {
  region = "${var.regionName}"
}

resource "aws_ecr_repository" "spring-boot-sample-app-ecr" {
  name = "${var.serviceName}"
}
output "ecr_repository_name" {
    description = "ECR Repository url"
    value = aws_ecr_repository.spring-boot-sample-app-ecr.repository_url
}