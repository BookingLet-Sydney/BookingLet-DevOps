[
    {
        "name": "sss",
        "image": "sss",
        "cpu": 123,
        "memory": "350",
        "essential": true,
        "portMappings": [
            {
                "containerPort": "1234",
                "protocol": "tcp"
            }
        ],
        "environmentFiles": [
            {
                "value": "${environmentFiles}",
                "type": "s3"
            }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "/ecs/{task-definition-name}",
                "awslogs-region": "ap-southeast-2",
                "awslogs-stream-prefix": "ecs"
            }
        }
    }
]