{
  "cpu": ${cpu},
  "image": "${image}",
  "memory": ${memory},
  "name": "${service}",
  "essential": true,
  "portMappings": ${jsonencode([])},
  "logConfiguration": {},
  "environment": ${environment},
  "command": ${commands}
}
