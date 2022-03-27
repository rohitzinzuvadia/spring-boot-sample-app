terraform {
  backend "s3" {
  }
}
provider "aws" {
  region = "${var.region}"
}
resource "aws_cloudwatch_log_group" "sample-ecs-task-log" {
  name = "clg-dev-sample-ecs-task"
  retention_in_days =  14  

  tags = {
    Environment = "dev"
    Application = "sample-ecs-task"
  }
}

resource "aws_ecs_task_definition" "sample-ecs-task" {
    family = "${var.serviceName}"
    requires_compatibilities = ["FARGATE","EC2"]
    network_mode = "awsvpc"
    task_role_arn = "arn:aws:iam::635489002009:role/Sample-App-Role"
    execution_role_arn =  "arn:aws:iam::635489002009:role/Sample-App-Role"
    cpu=256
    memory=512
    container_definitions = <<EOF
    [
        {
            "name":"sample-ecs-task-001",
            "image":"${var.ecrPath}:${var.env}",
            "cpu":256,
            "memory":512,
            "essential": true,
            "entryPoint": [
                "/bin/bash"
            ],
            "command": [
                "/app/bin/runApp",
                "${var.env}"
            ],
            "privileged": false,
            "portMappings": [
                {
                    "containerPort": 80,
                    "hostPort": 80,
                    "protocol": "tcp"
                }
            ],
            "essential": true,
            "logConfiguration": {
                "logDriver": "awslogs",
                "options": {
                    "awslogs-group": aws_cloudwatch_log_group.sample-ecs-task-log.name,
                    "awslogs-region": "${var.region}",
		            "awslogs-stream-prefix":"${var.serviceName}-${var.env}"
                }
            }
        }
    ]
    EOF
}