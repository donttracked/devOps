# Параметры для провайдера
yc_token     = ""
yc_cloud_id  = "b1gvl2225noj5jh7jvr5"
yc_folder_id = "b1gvl2225noj5jh7jvr5"
yc_zone      = "ru-central1-a"

# Параметры для модулей
vpc_network  = "default"                 # Имя вашей VPC-сети
network_zones = ["ru-central1-a", "ru-central1-b", "ru-central1-d"]  # Список зон
vm_zone      = "ru-central1-a"          # Зона для создания ВМ
vm_name      = "my-vm"
image_id     = "fd874d4jo8jbroqs6d7i"
platform_id  = "standard-v1"
vm_resources = {
  cores         = 2
  memory        = 4
  core_fraction = 100
}
