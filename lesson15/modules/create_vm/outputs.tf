output "vm_id" {
  description = "ID созданной виртуальной машины."
  value       = yandex_compute_instance.vm_instance.id
}

output "vm_name" {
  description = "Имя созданной виртуальной машины."
  value       = yandex_compute_instance.vm_instance.name
}

output "vm_ip_address" {
  description = "Внешний IP-адрес созданной виртуальной машины."
  value       = yandex_compute_instance.vm_instance.network_interface.0.nat_ip_address
}
