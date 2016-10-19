#!/usr/bin/env bash

echo "127.0.0.1 sip_www" >> /etc/hosts

# Configura localização correta da infra_php
#if [ -d /mnt/sei/src/infra/infra_php ]; then dir_infra_php="/mnt/sei/src/infra/infra_php"; else dir_infra_php="/mnt/sei/src/infra_php"; fi
#ln -sf $dir_infra_php /var/www/html/

# Configura localização correta da infra_js
#if [ -d /mnt/sei/src/infra/infra_js ]; then dir_infra_js="/mnt/sei/src/infra/infra_js"; else dir_infra_js="/mnt/sei/src/infra_js"; fi
#ln -sf $dir_infra_js /var/www/html/

# Configura localização correta da infra_css
#if [ -d /mnt/sei/src/infra/infra_css ]; then dir_infra_css="/mnt/sei/src/infra/infra_css"; else dir_infra_css="/mnt/sei/src/infra_css"; fi
#ln -sf $dir_infra_css /var/www/html/

# Atribuição dos parâmetros de configuração do SEI
if [ -f /opt/sei/config/ConfiguracaoSEI.php ] && [ ! -f /opt/sei/config/ConfiguracaoSEI.php~ ]; then
    mv /opt/sei/config/ConfiguracaoSEI.php /opt/sei/config/ConfiguracaoSEI.php~
fi

if [ ! -f /opt/sei/config/ConfiguracaoSEI.php ]; then
    cp /ConfiguracaoSEI.php /opt/sei/config/ConfiguracaoSEI.php
fi

# Atribuição dos parâmetros de configuração do SIP
if [ -f /opt/sip/config/ConfiguracaoSip.php ] && [ ! -f /opt/sip/config/ConfiguracaoSip.php~ ]; then
    mv /opt/sip/config/ConfiguracaoSip.php /opt/sip/config/ConfiguracaoSip.php~
fi

if [ ! -f /opt/sip/config/ConfiguracaoSip.php ]; then
    cp /ConfiguracaoSip.php /opt/sip/config/ConfiguracaoSip.php
fi

# Criação do diretório padrão de upload de arquivos
#SEI
chown -R www-data.www-data /opt/sei
chown -R www-data.www-data /opt/infra
chown -R www-data.www-data /opt/sip
chmod +x /opt/sei/bin/wkhtmltopdf-amd64
chmod -R 777 /opt/sei/temp
chmod -R 777 /opt/sip/temp
chmod -R 777 /var/sei/arquivos

# Inicialização do serviço de cache
#/etc/init.d/memcached start

# Inicialização das rotinas de agendamento
service cron start 

# Inicialização do Gearman e Supervisor, componentes para integração com Processo Eletrônico Nacional
gearmand &
service supervisor start

# Inicialização do servidor web
apache2-foreground
