terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "~> 0.70"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
  token     = var.yandex_token
  cloud_id  = var.yandex_cloud_id
  folder_id = var.yandex_folder_id
}

data "yandex_compute_image" "ubuntu" {
  family = "ubuntu-2004-lts"
}

resource "yandex_vpc_network" "my_network" {
  name = "my-network"
}

resource "yandex_vpc_subnet" "public_subnet" {
  name           = "public-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.my_network.id
  v4_cidr_blocks = ["10.0.0.0/24"]
}

resource "yandex_vpc_subnet" "private_subnet" {
  name           = "private-subnet"
  zone           = var.zone
  network_id     = yandex_vpc_network.my_network.id
  v4_cidr_blocks = ["10.0.1.0/24"]
  route_table_id = yandex_vpc_route_table.my_route_table.id
}

resource "yandex_vpc_gateway" "nat_gateway" {
  name = "nat-gateway"

  shared_egress_gateway {}
}

resource "yandex_vpc_route_table" "my_route_table" {
  name       = "private-route-table"
  network_id = yandex_vpc_network.my_network.id

  static_route {
    destination_prefix = "0.0.0.0/0"
    gateway_id         = yandex_vpc_gateway.nat_gateway.id
  }
}

resource "yandex_vpc_security_group" "public_sg" {
  name       = "public-sg"
  network_id = yandex_vpc_network.my_network.id

  egress {
    description    = "Allow all outbound traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "Allow SSH from anywhere"
    protocol       = "TCP"
    port           = "22"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "Allow HTTP from anywhere"
    protocol       = "TCP"
    port           = "80"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "Allow HTTPS from anywhere"
    protocol       = "TCP"
    port           = "443"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_vpc_security_group" "private_sg" {
  name       = "private-sg"
  network_id = yandex_vpc_network.my_network.id

  egress {
    description    = "Allow all outbound traffic"
    protocol       = "ANY"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description    = "Allow SSH from public subnet"
    protocol       = "TCP"
    port           = "22"
    v4_cidr_blocks = [yandex_vpc_subnet.public_subnet.v4_cidr_blocks[0]]
  }

  ingress {
    description    = "Allow port 8080 from public subnet"
    protocol       = "TCP"
    port           = "8080"
    v4_cidr_blocks = [yandex_vpc_subnet.public_subnet.v4_cidr_blocks[0]]
  }
}

resource "yandex_compute_instance" "public" {
  name        = "public-vm"
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.public_subnet.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.public_sg.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      "sudo systemctl enable nginx",
      "sudo systemctl start nginx"
    ]
    connection {
      type        = "ssh"
      host        = self.network_interface[0].nat_ip_address
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
    }
  }
}

resource "yandex_compute_instance" "private" {
  name        = "private-vm"
  platform_id = "standard-v1"
  zone        = var.zone

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.id
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.private_subnet.id
    security_group_ids = [yandex_vpc_security_group.private_sg.id]
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }

  # Провижининг частной ВМ через bastion host
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y nginx",
      # Настройка Nginx на прослушивание порта 8080
      "sudo sed -i 's/listen 80 default_server;/listen 8080 default_server;/' /etc/nginx/sites-available/default",
      "sudo sed -i 's/listen \\[::\\]:80 default_server;/listen \\[::\\]:8080 default_server;/' /etc/nginx/sites-available/default",
      "sudo systemctl restart nginx"
    ]
    connection {
      type                 = "ssh"
      host                 = self.network_interface[0].ip_address
      user                 = "ubuntu"
      private_key          = file("~/.ssh/id_rsa")
      bastion_host         = yandex_compute_instance.public.network_interface[0].nat_ip_address
      bastion_user         = "ubuntu"
      bastion_private_key  = file("~/.ssh/id_rsa")
    }
  }
}

output "public_instance_ip" {
  value = yandex_compute_instance.public.network_interface[0].nat_ip_address
}

output "private_instance_ip" {
  value = yandex_compute_instance.private.network_interface[0].ip_address
}