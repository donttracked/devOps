provider "yandex" {
  token     = var.yc_token      # Ваш OAuth-токен или IAM-токен
  cloud_id  = var.yc_cloud_id   # ID вашего облака
  folder_id = var.yc_folder_id  # ID вашей папки
  zone      = var.yc_zone       # Зона по умолчанию (можно переопределить в ресурсах)
}
