{
  "cpu": ${cpu},
  "image": "${image}",
  "memory": ${memory},
  "name": "${service}",
  "essential": true,
  "portMappings": ${jsonencode([])},
  "logConfiguration": ${jsonencode(
    for log_group in jsondecode(log_groups) : {
      logDriver: "awslogs",
      options: {
        awslogs-group: log_group,
        awslogs-region: region,
        awslogs-stream-prefix: service
      }
    }
  )},
  "environment": ${environment},
  "command": ${commands}
}
