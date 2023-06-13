FROM php:7.4-apache

# Copiar os arquivos do seu projeto para o diretório do Apache
COPY ./index.php /var/www/html/

# Configurar as permissões corretas para o Apache
RUN chown -R www-data:www-data /var/www/html/

# Expor a porta 80
EXPOSE 80

