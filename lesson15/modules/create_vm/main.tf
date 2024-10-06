resource "yandex_compute_instance" "vm_instance" {
  name        = var.vm_name
  platform_id = var.platform_id
  zone        = var.vm_zone

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
    subnet_id = var.subnet_id

    nat = true
  }
}
