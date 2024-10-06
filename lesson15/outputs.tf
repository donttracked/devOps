# Вывод информации о подсетях
output "all_subnets" {
  value = module.data_subnets.subnets
}

# Вывод информации о созданной ВМ
output "vm_info" {
  value = {
    id         = module.create_vm.vm_id
    name       = module.create_vm.vm_name
    ip_address = module.create_vm.vm_ip_address
  }
}
