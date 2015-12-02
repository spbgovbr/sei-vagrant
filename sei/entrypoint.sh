#!/usr/bin/env bash

echo "127.0.0.1 sip_www" | tee -a /etc/hosts

# Configura localização das aplicações SEI e SIP
ln -s /mnt/sei/src/sei /var/www/html/
ln -s /mnt/sei/src/sip /var/www/html/

# Configura localização correta da infra_php
if [ -d /mnt/sei/src/infra/infra_php ]; then dir_infra_php="/mnt/sei/src/infra/infra_php"; else dir_infra_php="/mnt/sei/src/infra_php"; fi
ln -sf $dir_infra_php /var/www/html/

# Configura localização correta da infra_js
if [ -d /mnt/sei/src/infra/infra_js ]; then dir_infra_js="/mnt/sei/src/infra/infra_js"; else dir_infra_js="/mnt/sei/src/infra_js"; fi
ln -sf $dir_infra_js /var/www/html/

# Configura localização correta da infra_css
if [ -d /mnt/sei/src/infra/infra_css ]; then dir_infra_css="/mnt/sei/src/infra/infra_css"; else dir_infra_css="/mnt/sei/src/infra_css"; fi
ln -sf $dir_infra_css /var/www/html/

# Atribuição dos parâmetros de configuração do SEI
if [ -f /var/www/html/sei/ConfiguracaoSEI.php ] && [ ! -f /var/www/html/sei/ConfiguracaoSEI.php~ ]; then
    mv /var/www/html/sei/ConfiguracaoSEI.php /var/www/html/sei/ConfiguracaoSEI.php~
fi

if [ ! -f /var/www/html/sei/ConfiguracaoSEI.php ]; then
    cp /opt/sei/ConfiguracaoSEI.php /var/www/html/sei/ConfiguracaoSEI.php
fi

# Atribuição dos parâmetros de configuração do SIP
if [ -f /var/www/html/sip/ConfiguracaoSip.php ] && [ ! -f /var/www/html/sip/ConfiguracaoSip.php~ ]; then
    mv /var/www/html/sip/ConfiguracaoSip.php /var/www/html/sip/ConfiguracaoSip.php~
fi

if [ ! -f /var/www/html/sip/ConfiguracaoSip.php ]; then
    cp /opt/sip/ConfiguracaoSip.php /var/www/html/sip/ConfiguracaoSip.php
fi

# Configura localização das aplicações SEI e SIP
ln -s /mnt/sei/src/sei /var/www/html/sei
ln -s /mnt/sei/src/sip /var/www/html/sip

# Configura localização correta da infra_php
if [ ! -d /var/www/html/infra_php ]; then
    ln -s /mnt/sei/src/infra/infra_php /var/www/html/infra_php
fi

# Configura localização correta da infra_js
if [ ! -d /var/www/html/infra_js ]; then
    ln -s /mnt/sei/src/infra/infra_js /var/www/html/infra_js
fi

# Criação do diretório padrão de upload de arquivos
mkdir /var/www/html/sei/upload && chmod -R 666 /var/www/html/sei/upload
mkdir /var/www/html/sip/upload && chmod -R 666 /var/www/html/sip/upload

# Permissão de execução para utilitário de conversão de PDFs
chmod +x /var/www/html/sei/ferramentas/wkhtmltopdf-amd64

# Inicialização do serviço de cache
/etc/init.d/memcached start

# Inicialização das rotinas de agendamento
/etc/init.d/rsyslog start 
/etc/init.d/crond start 

# Inicialização do servidor web
/usr/sbin/httpd -DFOREGROUND
