resource "aws_ecs_task_definition" "sample-ecs-task" {
    family = ""
    container_definitions = [
        {
            "name":"containername"
            "image":"ecr image"
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