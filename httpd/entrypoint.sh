#!/usr/bin/env bash

mkdir -p /opt/sip/config/
mkdir -p /opt/sei/config/

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
printenv | sed 's/^\(.*\)$$/export \1/g' > /crond_env.sh	
chown root:root /etc/cron.d/sei
chmod 0644 /etc/cron.d/sei
crond 

# Atualização do endereço de host da aplicação
SEI_HOST_URL=${SEI_HOST_URL:-"http://localhost:8080"}
SEI_DATABASE_NAME=${SEI_DATABASE_NAME:-"sei"}
SEI_DATABASE_USER=${SEI_DATABASE_USER:-"root"}
SEI_DATABASE_PASSWORD=${SEI_DATABASE_PASSWORD:-"root"}
SIP_DATABASE_NAME=${SIP_DATABASE_NAME:-"sip"}
SIP_DATABASE_USER=${SIP_DATABASE_USER:-"root"}
SIP_DATABASE_PASSWORD=${SIP_DATABASE_PASSWORD:-"root"}


# Atualizar os endereços de host definidos para na inicialização
php -r "
    require_once '/opt/sip/web/Sip.php';
    \$conexao = BancoSip::getInstance();
    \$conexao->abrirConexao();
    \$conexao->executarSql(\"update sistema set pagina_inicial='$SEI_HOST_URL/sip' where sigla='SIP'\");
    \$conexao->executarSql(\"update sistema set pagina_inicial='$SEI_HOST_URL/sei/inicializar.php' where sigla='SEI'\");
" || exit 1

# Inicialização do servidor web
/usr/sbin/httpd -DFOREGROUND
