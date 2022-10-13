locals {
  main_definition = templatefile(
    local.logs_enabled ? "${path.module}/container_definition_logging.tpl" : "${path.module}/container_definition.tpl",
    {
      service     = var.service
      region      = data.aws_region.current.name
      image       = var.container.image
      cpu         = var.container.cpu
      memory      = var.container.memory
      commands    = jsonencode(var.container.commands)
      environment = jsonencode(var.container.environment)
      log_group   = var.log_group
    }
  )
}
