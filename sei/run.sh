#!/bin/bash

echo "127.0.0.1 sip_www" | tee -a /etc/hosts

# Atribuição dos parâmetros de configuração do SEI
cp /mnt/sei/ops/sei/ConfiguracaoSEI.php /var/www/html/sei/ConfiguracaoSEI.php
cp /mnt/sei/ops/sip/ConfiguracaoSip.php /var/www/html/sip/ConfiguracaoSip.php

# Criação do diretório padrão de upload de arquivos
mkdir /var/www/html/sei/upload && chmod -R 666 /var/www/html/sei/upload
mkdir /var/www/html/sip/upload && chmod -R 666 /var/www/html/sip/upload

# Inicialização do serviço de cache
/etc/init.d/memcached start 2>&1 > /dev/null

# Inicialização do servidor web
/usr/sbin/httpd -DFOREGROUND
