data "yandex_vpc_network" "default" {
  name = var.vpc_network
}

data "yandex_vpc_subnet" "subnet" {
  for_each = toset(var.network_zones)
  name     = "${data.yandex_vpc_network.default.name}-${each.key}"  # Предполагаем, что имя подсети формируется как "vpc_name-zone"
}

# Пример, имя подсети следует шаблону "vpc_name-zone":