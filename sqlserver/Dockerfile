################################################################################
# Dockerfile de construção do container SqlServer utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
# SQL Server para Linux é uma versão experimental e não deve ser utilizada em
# ambiente de produção
################################################################################

FROM liaisonintl/mssql-server-linux

ARG VERSAO_BASE=v4.0.0
ARG REPOSITORIO_BASE=https://github.com/spbgovbr/sei-db-ref-executivo/blob/master/sqlserver/$VERSAO_BASE

############################# INÍCIO DA INSTALACAO #############################
ENV TERM xterm
ENV ACCEPT_EULA=Y
ENV SA_PASSWORD='P@ssword'

ADD $REPOSITORIO_BASE/sei_4_0_0_BD_Ref_Exec.bak?raw=true /tmp/sei_sqlserver.bak
ADD $REPOSITORIO_BASE/sip_4_0_0_BD_Ref_Exec.bak?raw=true /tmp/sip_sqlserver.bak
COPY assets/restore.sql /tmp/restore.sql
COPY install.sh /install.sh

RUN bash /install.sh
############################## FIM DA INSTALACAO ###############################

# Imagem de base já configura a exposição das portas 1521 e inicialização do
# servidor de banco de dados com as configurações padrões
