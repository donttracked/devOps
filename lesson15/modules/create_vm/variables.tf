variable "subnets" {
  type = list(object({
    id   = string
    zone = string
  }))
  description = "Список подсетей с их зонами."
}

variable "zone" {
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
  description = "ID платформы для ВМ (например, 'standard-v1')."
}

variable "resources" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  description = "Ресурсы, выделенные для ВМ."
}