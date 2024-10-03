variable "subnet_id" {
  type        = string
  description = "ID подсети, в которой будет создана ВМ."
}

variable "vm_zone" {
  type        = string
  description = "Зона, в которой будет создана ВМ."
}

variable "vm_name" {
  type        = string
  description = "Имя виртуальной машины."
}

variable "image_id" {
  type        = string
  description = "ID образа для создания ВМ."
}

variable "platform_id" {
  type        = string
  description = "ID платформы для ВМ."
}

variable "resources" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  description = "Ресурсы, выделенные для ВМ."
}
