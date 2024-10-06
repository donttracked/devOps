variable "vpc_network" {
  type        = string
  description = "Имя выбранной VPC-сети."
}

variable "network_zones" {
  type        = list(string)
  description = "Список зон, для которых необходимо получить подсети."
}
