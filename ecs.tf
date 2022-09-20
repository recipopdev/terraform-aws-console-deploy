data "aws_region" "current" {}

resource "aws_ecs_service" "main" {
  name                 = var.service
  cluster              = var.cluster
  task_definition      = aws_ecs_task_definition.main.arn
  launch_type          = "FARGATE"
  desired_count        = var.container.count
  force_new_deployment = true
  propagate_tags       = "SERVICE"

  network_configuration {
    security_groups = [aws_security_group.main.id]
    subnets         = var.network.subnets
  }
  
  deployment_circuit_breaker {
    enable   = true
    rollback = true
  }
  
  lifecycle {
    ignore_changes = [
      desired_count
    ]
  }
}

resource "aws_ecs_task_definition" "main" {
  family                   = var.service
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.container.cpu
  memory                   = var.container.memory
  execution_role_arn       = aws_iam_role.main.arn
  task_role_arn            = aws_iam_role.main.arn
  container_definitions    = "[${local.main_definition}]"
  skip_destroy             = true
  runtime_platform {
    operating_system_family = var.windows_deployment ? "WINDOWS_SERVER_2019_CORE" : "LINUX"
    cpu_architecture        = "X86_64"
  }
}
