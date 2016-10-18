#!/usr/bin/env bash

echo "127.0.0.1 sip_www" >> /etc/hosts

# Configura localização das aplicações SEI e SIP
ln -s /mnt/sei/src/sei /opt/
ln -s /mnt/sei/src/sip /opt/

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
    cp /opt/ConfiguracaoSEI.php /opt/sei/config/ConfiguracaoSEI.php
fi

# Atribuição dos parâmetros de configuração do SIP
if [ -f /opt/sip/config/ConfiguracaoSip.php ] && [ ! -f /opt/sip/config/ConfiguracaoSip.php~ ]; then
    mv /opt/sip/config/ConfiguracaoSip.php /opt/sip/config/ConfiguracaoSip.php~
fi

if [ ! -f /opt/sip/config/ConfiguracaoSip.php ]; then
    cp /opt/sip/config/ConfiguracaoSip.php /opt/sip/config/ConfiguracaoSip.php
fi

# Criação do diretório padrão de upload de arquivos
#SEI
chown -R root.apache /opt/sei
find /opt/sei -type d -exec chmod 2750 {} \;
find /opt/sei -type f -exec chmod 0640 {} \;
find /opt/sei/temp -type d -exec chmod 2570 {} \;
chmod 0750 /opt/sei/bin/wkhtmltopdf-amd64

#SIP
chown -R root.apache /opt/sip
find /opt/sip -type d -exec chmod 2750 {} \;
find /opt/sip -type f -exec chmod 0640 {} \;
find /opt/sip/temp -type d -exec chmod 2570 {} \;

#Infra PHP
chown -R root.apache /opt/infra
find /opt/infra -type d -exec chmod 2750 {} \;
find /opt/infra -type f -exec chmod 0640 {} \;

chmod -R 777 /var/sei/arquivos

# Inicialização do serviço de cache
#/etc/init.d/memcached start

# Inicialização das rotinas de agendamento
/etc/init.d/rsyslog start 
/etc/init.d/crond start 

# Inicialização do Gearman e Supervisor, componentes para integração com Processo Eletrônico Nacional
/etc/init.d/gearmand start 
/etc/init.d/supervisord start

# Inicialização do servidor web
/usr/sbin/httpd -DFOREGROUND
