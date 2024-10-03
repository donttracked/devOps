# Вызов модуля data_subnets для получения subnet_id на основе zone
module "data_subnets" {
  source = "./modules/data_subnets"

  vpc_network   = var.vpc_network
  network_zones = var.network_zones
}

# Вызов модуля create_vm с передачей соответствующего subnet_id
module "create_vm" {
  source = "./modules/create_vm"

  subnet_id   = module.data_subnets.subnets[var.vm_zone].id
  vm_zone     = var.vm_zone
  vm_name     = var.vm_name
  image_id    = var.image_id
  platform_id = var.platform_id
  resources   = var.vm_resources
}