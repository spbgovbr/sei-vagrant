################################################################################
# Dockerfile de construção do container do Oracle utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

MAINTAINER PEN - Processo Eletrônico Nacional
FROM wnameless/oracle-xe-11g

############################# INÍCIO DA INSTALACAO #############################

ENV ORACLE_ALLOW_REMOTE=true
ENV NLS_LANG=PORTUGUESE_BRAZIL.WE8ISO8859P1

COPY pre-install.sql /tmp/pre-install.sql
#todo: Necessário migrar dumps para git submodule
COPY SEI_3.0.0.dmp /tmp/sei.dmp
COPY SIP_3.0.0.dmp /tmp/sip.dmp
COPY sei-config.sql /tmp/sei-config.sql
COPY sip-config.sql /tmp/sip-config.sql
COPY install.sh /install.sh

RUN bash /install.sh

############################## FIM DA INSTALACAO ###############################

# Imagem de base já configura a exposição das portas 1521 e inicialização do
# servidor de banco de dados com as configurações padrões
