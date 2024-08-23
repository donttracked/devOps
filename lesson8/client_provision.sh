#!/bin/bash

# Добавляем домен в /etc/hosts
echo "192.168.56.102 site.local www.site.local" | sudo tee -a /etc/hosts

# Устанавливаем сертификат в доверенные
sudo cp /home/vagrant/shared_folder/site.local.crt /usr/local/share/ca-certificates/site.local.crt
sudo update-ca-certificates
