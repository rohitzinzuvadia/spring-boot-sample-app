resource "aws_ecs_task_definition" "sample-ecs-task" {
    family = "${var.serviceName}"
    requires_compatibilities = ["FARGATE","EC2"]
    network_mode = "awsvpc"
    task_role_arn = "arn:aws:iam::635489002009:role/Sample-App-Role"
    execution_role_arn =  "arn:aws:iam::635489002009:role/Sample-App-Role"
    cpu=10
    memory=512
    container_definitions = <<EOF
    [
        {
            "name":"sample-ecs-task-001"
            "image":"${var.ecrPath}:${var.env}"
            "cpu":10
            "memory":512
            "essential": true,
            "portMappings": [
                {
                    "containerPort": 80,
                    "hostPort": 80
                    "protocol": "tcp"
                }
            ]
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