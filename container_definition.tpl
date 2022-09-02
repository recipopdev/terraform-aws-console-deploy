{
  "cpu": ${cpu},
  "image": "${image}",
  "memory": ${memory},
  "name": "${service}",
  "essential": true,
  "portMappings": ${jsonencode([])},
  "logConfiguration": {
    "logDriver": "awslogs",
    "options": {
      "awslogs-group": "${log_group}",
      "awslogs-region": "${region}",
      "awslogs-stream-prefix": "${service}"
    }
  },
  "environment": ${environment},
  "command": ${commands}
}