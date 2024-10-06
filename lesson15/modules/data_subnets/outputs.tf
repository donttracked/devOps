output "subnets" {
  description = "Карта подсетей, где ключ — зона, а значение — объект с ID подсети."
  value = {
  for zone, subnet in data.yandex_vpc_subnet.subnet :
  zone => {
    id = subnet.id
  }
  }
}