################################################################################
# Dockerfile de construção do container do MySQL utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

MAINTAINER PEN - Processo Eletrônico Nacional
FROM centos:centos6

############################# INÍCIO DA INSTALACAO #############################
# Instalação do MySQL seguindo as recomendações descritas na documentação do SEI

ENV TERM xterm

COPY sei-db-ref-executivo/mysql/sei_3_0_0_BD_Ref_Exec.sql /tmp/sei_mysql.sql
COPY sei-db-ref-executivo/mysql/sip_3_0_0_BD_Ref_Exec.sql /tmp/sip_mysql.sql
COPY install.sh /install.sh

RUN bash /install.sh

############################## FIM DA INSTALACAO ###############################

EXPOSE 3306
CMD ["/entrypoint.sh"]
