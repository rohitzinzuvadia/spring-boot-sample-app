resource "aws_ecs_task_definition" "sample-ecs-task" {
    family = "${var.serviceName}"
    container_definitions = [
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
                }
            ]
        }
    ]
  
}