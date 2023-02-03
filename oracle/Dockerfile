################################################################################
# Dockerfile de construção do container do Oracle utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

FROM oracleinanutshell/oracle-xe-11g


ARG VERSAO_BASE=v4.0.x.1
ARG REPOSITORIO_BASE=https://github.com/supergovbr/super-db-ref-executivo/blob/master/oracle/$VERSAO_BASE


############################# INÍCIO DA INSTALACAO #############################
ENV TERM xterm
ENV ORACLE_ALLOW_REMOTE=true
ENV NLS_LANG=PORTUGUESE_BRAZIL.WE8MSWIN1252

ADD $REPOSITORIO_BASE/sei_super_4.0.x.1_BD_Ref_Exec.dmp?raw=true /tmp/sei_oracle.dmp
ADD $REPOSITORIO_BASE/sip_super_4.0.x.1_BD_Ref_Exec.dmp?raw=true /tmp/sip_oracle.dmp
COPY assets/pre-install.sql /tmp/pre-install.sql
COPY assets/sei-config.sql /tmp/sei-config.sql
COPY assets/sip-config.sql /tmp/sip-config.sql
COPY install.sh /install.sh


RUN bash /install.sh
############################## FIM DA INSTALACAO ###############################

# Imagem de base já configura a exposição das portas 1521 e inicialização do
# servidor de banco de dados com as configurações padrões
