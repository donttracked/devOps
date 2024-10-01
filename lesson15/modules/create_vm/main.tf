locals {
  subnets_in_zone = [
  for subnet in var.subnets : subnet
  if subnet.zone == var.zone
  ]
}

resource "yandex_compute_instance" "vm_instance" {
  name        = var.vm_name
  platform_id = var.platform_id
  zone        = var.zone

  resources {
    cores         = var.resources.cores
    memory        = var.resources.memory
    core_fraction = var.resources.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = var.image_id
    }
  }

  network_interface {
    subnet_id = local.subnets_in_zone[0].id
  }
}
