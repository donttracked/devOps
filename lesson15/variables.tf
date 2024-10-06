# Переменные для провайдера
variable "yc_token" {
  type        = string
  description = "OAuth-токен или IAM-токен для доступа к Яндекс Облаку."
}

variable "yc_cloud_id" {
  type        = string
  description = "ID облака в Яндекс Облаке."
}

variable "yc_folder_id" {
  type        = string
  description = "ID папки в Яндекс Облаке."
}

variable "yc_zone" {
  type        = string
  description = "Зона по умолчанию."
  default     = "ru-central1-a"
}

# Переменные для модулей
variable "vpc_network" {
  type        = string
  description = "Имя выбранной VPC-сети."
}

variable "network_zones" {
  type        = list(string)
  description = "Список зон, для которых необходимо получить подсети."
}

variable "vm_zone" {
  type        = string
  description = "Зона для создания ВМ."
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

variable "vm_resources" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  description = "Ресурсы, выделенные для ВМ."
}
