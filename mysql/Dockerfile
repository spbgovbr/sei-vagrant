################################################################################
# Dockerfile de construção do container do MySQL utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

FROM centos:centos6
MAINTAINER Guilherme Andrade Del Cantoni <guilherme.cantoni@planejamento.gov.br>

############################# INÍCIO DA INSTALAÇÃO #############################
ENV TERM xterm

COPY sei-db-ref-executivo/mysql/sei_3_0_0_BD_Ref_Exec.sql /tmp/sei_mysql.sql
COPY sei-db-ref-executivo/mysql/sip_3_0_0_BD_Ref_Exec.sql /tmp/sip_mysql.sql
COPY install.sh /install.sh

RUN sh /install.sh
############################## FIM DA INSTALAÇÃO ###############################

EXPOSE 3306
CMD ["/entrypoint.sh"]
