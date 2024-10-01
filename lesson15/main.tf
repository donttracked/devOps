# Определение локальной переменной с подсетями
locals {
  subnets = [
    {
      id   = "e9bov5qhaosdubvl3t4v"
      zone = "ru-central1-a"
    },
    {
      id   = "e2lr98850d58m2luhivh"
      zone = "ru-central1-b"
    },
    # Добавьте другие подсети по необходимости
  ]
}

module "data_subnets" {
  source = "./modules/data_subnets"

  subnets = local.subnets
}

module "create_vm" {
  source = "./modules/create_vm"

  subnets     = local.subnets
  zone        = var.vm_zone
  vm_name     = var.vm_name
  image_id    = var.image_id
  platform_id = var.platform_id
  resources   = var.vm_resources
}
