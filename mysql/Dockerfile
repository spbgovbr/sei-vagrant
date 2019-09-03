################################################################################
# Dockerfile de construção do container do MySQL utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

FROM mysql:8
MAINTAINER Guilherme Andrade Del Cantoni <guilherme.cantoni@planejamento.gov.br>

############################# INÍCIO DA INSTALAÇÃO #############################
ENV MYSQL_ROOT_PASSWORD=root

COPY assets/pre-install.sql /docker-entrypoint-initdb.d/1_pre-install.sql
COPY sei-db-ref-executivo/mysql/sei_3_0_0_BD_Ref_Exec.sql /docker-entrypoint-initdb.d/2_sei_3_0_0_BD_Ref_Exec.sql
COPY sei-db-ref-executivo/mysql/sip_3_0_0_BD_Ref_Exec.sql /docker-entrypoint-initdb.d/3_sip_3_0_0_BD_Ref_Exec.sql
COPY assets/pos-install.sql /docker-entrypoint-initdb.d/9_pos-install.sql
COPY assets/my.cnf /etc/mysql/conf.d/sei.cnf

RUN sed -i '1i use sei; \n' /docker-entrypoint-initdb.d/2_sei_3_0_0_BD_Ref_Exec.sql
RUN sed -i '1i use sip; \n' /docker-entrypoint-initdb.d/3_sip_3_0_0_BD_Ref_Exec.sql

############################## FIM DA INSTALAÇÃO ###############################

ENTRYPOINT ["/entrypoint.sh"]
#HEALTHCHECK CMD /healthcheck.sh
HEALTHCHECK --interval=5s --timeout=10s --retries=120 CMD /healthcheck.sh 
 
EXPOSE 3306
CMD ["mysqld"]
