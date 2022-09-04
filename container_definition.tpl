{
  "cpu": ${cpu},
  "image": "${image}",
  "memory": ${memory},
  "name": "${service}",
  "essential": true,
  "portMappings": ${jsonencode([])},
  "environment": ${environment},
  "command": ${commands}
}
