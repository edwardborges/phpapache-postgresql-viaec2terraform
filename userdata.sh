#!/bin/bash
sudo apt update
sudo apt install docker.io -y
sudo usermod -aG docker $USER
sudo systemctl enable docker.service
sudo systemctl start docker.service

# Executar o contêiner do Apache + PHP
sudo docker run -d --name my_apache_php -p 80:80 -v /home/user/php/files:/var/www/html php:7.4-apache

# Copiar arquivo index.php para o contêiner
sudo docker cp index.php my_apache_php:/var/www/html

#Atualizar pacotes de Ubuntu 20.04 na versão amazon é necessário 
sudo su
apt list --upgradable

# Instalação do PostgreSQL
sudo apt install postgresql postgresql-contrib -y

# Configuração do PostgreSQL para aceitar apenas conexões locais
sudo sed -i "s/#listen_addresses = 'localhost'/listen_addresses = 'localhost'/g" /etc/postgresql/13/main/postgresql.conf
echo "host    all             all             127.0.0.1/32            trust" | sudo tee -a /etc/postgresql/13/main/pg_hba.conf

# Iniciar o serviço do PostgreSQL
sudo systemctl enable postgresql
sudo systemctl start postgresql
