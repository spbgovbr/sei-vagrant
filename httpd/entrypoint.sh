#!/usr/bin/env bash

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

# Ajustes de permissões diversos para desenvolvimento do SEI
chmod +x /opt/sei/bin/wkhtmltopdf-amd64
chmod +x /opt/sei/bin/pdfboxmerge.jar
chmod -R 777 /opt/sei/temp
chmod -R 777 /opt/sip/temp
chmod -R 777 /var/sei/arquivos

# Inicialização das rotinas de agendamento
/etc/init.d/rsyslog start
/etc/init.d/crond start

# Atualização do endereço de host da aplicação
echo "Slepping..." && sleep 10
SEI_HOST_URL=${SEI_HOST_URL:-"http://localhost"}
SEI_DATABASE_NAME=${SIP_DATABASE_NAME:-"sei"}
SEI_DATABASE_USER=${SEI_DATABASE_USER:-"root"}
SEI_DATABASE_PASSWORD=${SEI_DATABASE_PASSWORD:-"root"}
SIP_DATABASE_NAME=${SIP_DATABASE_NAME:-"sip"}
SIP_DATABASE_USER=${SIP_DATABASE_USER:-"root"}
SIP_DATABASE_PASSWORD=${SIP_DATABASE_PASSWORD:-"root"}

MYSQL_CMD="mysql --host mysql --user $SIP_DATABASE_USER --password=$SIP_DATABASE_PASSWORD sip"
SQLSERVER_CMD="tsql -S sqlserver -U $SIP_DATABASE_USER -P $SIP_DATABASE_PASSWORD -D sip"

echo "update sistema set pagina_inicial='$SEI_HOST_URL/sip' where sigla='SIP';" > /tmp/update_file.sql
echo "update sistema set pagina_inicial='$SEI_HOST_URL/sei/inicializar.php' where sigla='SEI';" >> /tmp/update_file.sql
echo "go" >> /tmp/update_file.sql

$MYSQL_CMD < /tmp/update_file.sql || true
$SQLSERVER_CMD < /tmp/update_file.sql || true

# Inicialização do servidor web
/usr/sbin/httpd -DFOREGROUND
