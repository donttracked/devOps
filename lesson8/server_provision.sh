#!/bin/bash

# Обновляем пакеты и устанавливаем Apache
sudo apt-get update
sudo apt-get install -y apache2

# Включаем необходимые модули Apache
sudo a2enmod ssl
sudo a2enmod rewrite

# Создаем директорию для сайта
sudo mkdir -p /var/www/site.local

# Устанавливаем права на директорию
sudo chown -R $USER:$USER /var/www/site.local
sudo chmod -R 755 /var/www

# Создаем простой индексный файл
echo "<h1>Welcome to site.local</h1>" | sudo tee /var/www/site.local/index.html

# Настройка виртуального хоста для Apache
cat <<EOF | sudo tee /etc/apache2/sites-available/site.local.conf
<VirtualHost *:80>
    ServerAdmin admin@site.local
    ServerName site.local
    ServerAlias www.site.local
    DocumentRoot /var/www/site.local
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined

    # Перенаправление с HTTP на HTTPS
    RewriteEngine on
    RewriteCond %{SERVER_NAME} =www.site.local [OR]
    RewriteCond %{SERVER_NAME} =site.local
    RewriteRule ^ https://%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]
</VirtualHost>

<VirtualHost *:443>
    ServerAdmin admin@site.local
    ServerName site.local
    ServerAlias www.site.local
    DocumentRoot /var/www/site.local
    ErrorLog \${APACHE_LOG_DIR}/error.log
    CustomLog \${APACHE_LOG_DIR}/access.log combined

    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/site.local.crt
    SSLCertificateKeyFile /etc/ssl/private/site.local.key
</VirtualHost>
EOF

# Создаем самоподписанный сертификат
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/site.local.key \
    -out /etc/ssl/certs/site.local.crt \
    -subj "/C=RU/ST=State/L=City/O=Organization/OU=OrgUnit/CN=site.local"

sudo cp /etc/ssl/certs/site.local.crt /home/vagrant/shared_folder/

# Активируем сайт и перезапускаем Apache
sudo a2ensite site.local.conf
sudo systemctl reload apache2
