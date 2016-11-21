#!/usr/bin/env bash
set -e

# Variáveis de ambiente
export ORACLE_HOME=/u01/app/oracle/product/11.2.0/xe
export PATH=$ORACLE_HOME/bin:$PATH
export ORACLE_SID=XE
#export NLS_LANG=PORTUGUESE_BRAZIL.WE8MSWIN1252
export NLS_LANG=PORTUGUESE_BRAZIL.WE8ISO8859P1

# Inicialização do servidor
bash /usr/sbin/startup.sh

# Configuração do character set e outros parâmetros iniciais
sqlplus sys/oracle as sysdba @"/tmp/pre-install.sql"

# Restauração das bases de dados do SEI e SIP
impdp system/oracle file=/tmp/sei_oracle.dmp full=y
impdp system/oracle file=/tmp/sip_oracle.dmp full=y

# Configuração das bases de dados do sistema
sqlplus sei_user/sei_user @"/tmp/sei-config.sql"
sqlplus sip_user/sip_user @"/tmp/sip-config.sql"

# Remover arquivos temporários
rm -rf /tmp/*

exit 0
