locals {
  main_definition = templatefile(
    "${path.module}/container_definition.tpl",
    {
      service     = var.service
      region      = data.aws_region.current.name
      image       = var.container.image
      cpu         = var.container.cpu
      memory      = var.container.memory
      ports       = jsonencode([var.network.port])
      log_group   = var.log_group
      commands    = jsonencode(var.container.commands)
      environment = jsonencode(var.container.environment)
    }
  )
}