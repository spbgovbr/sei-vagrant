################################################################################
# Dockerfile de construção do container do Oracle utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

FROM oracleinanutshell/oracle-xe-11g
MAINTAINER Guilherme Andrade Del Cantoni <guilherme.cantoni@economia.gov.br>

############################# INÍCIO DA INSTALACAO #############################
ENV TERM xterm
ENV ORACLE_ALLOW_REMOTE=true
ENV NLS_LANG=PORTUGUESE_BRAZIL.WE8MSWIN1252

COPY sei-db-ref-executivo/oracle/v3.1.0/sei_3_1_0_BD_Ref_Exec.dmp /tmp/sei_oracle.dmp
COPY sei-db-ref-executivo/oracle/v3.1.0/sip_3_1_0_BD_Ref_Exec.dmp /tmp/sip_oracle.dmp

COPY assets/pre-install.sql /tmp/pre-install.sql
COPY assets/sei-config.sql /tmp/sei-config.sql
COPY assets/sip-config.sql /tmp/sip-config.sql
COPY install.sh /install.sh

RUN bash /install.sh
############################## FIM DA INSTALACAO ###############################

# Imagem de base já configura a exposição das portas 1521 e inicialização do
# servidor de banco de dados com as configurações padrões
