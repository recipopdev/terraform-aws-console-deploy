variable "service" {
  description = "The name of the service being deployed"
  type        = string
}

variable "cluster" {
  description = "The name of the cluster to deploy into"
  type        = string
}

variable "container" {
  description = "The details of the container that is being deployed"
  type = object({
    cpu          = number
    memory       = number
    image        = string
    count        = number
    environment  = list(map(string))
    commands     = list(string)
  })
}

variable "network" {
  description = "The network details for the swervice that is being deployed"
  type = object({
    vpc     = string
    subnets = list(string)
  })
}

variable "log_group" {
  description = "The Log group that the service will write to"
  type        = string
  default     = ""
}

variable "windows_deployment" {
  description = "Whether to create a windows deployment"
  type        = bool
  default     = false
}

locals {
  environment = terraform.workspace == "default" ? "dev" : terraform.workspace
}
