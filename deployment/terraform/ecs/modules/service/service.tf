resource "aws_cloudwatch_log_group" "sample-ecs-task-log" {
  name = "clg-${var.env}-${var.serviceName}"
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
                    "awslogs-group": "clg-${var.env}-${var.serviceName}",
                    "awslogs-region": "${var.region}",
		            "awslogs-stream-prefix":"${var.serviceName}-${var.env}"
                }
            }
        }
    ]
    EOF
}
resource "aws_ecs_service" "sample-ecs-service" {
    name            = "${var.serviceName}-${var.env}"
  cluster         = "${var.cluster}"
  task_definition = "${aws_ecs_task_definition.sample-ecs-task.arn}"
  desired_count   = "${var.desiredCount}"
  deployment_maximum_percent=200
  deployment_minimum_healthy_percent=0
  launch_type = "FARGATE"
  network_configuration {
			subnets =["${var.subnet1}",
			  "${var.subnet2}",
			  "${var.subnet3}"]
			assign_public_ip = true
			security_groups = ["${var.securityGroup}"]
		  }
}