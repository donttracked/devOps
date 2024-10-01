variable "subnets" {
  type = list(object({
    id   = string
    zone = string
  }))
  description = "Список подсетей с их зонами."
}
