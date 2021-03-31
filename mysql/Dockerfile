################################################################################
# Dockerfile de construção do container do MySQL utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

FROM mysql:8.0 as builder
LABEL maintainer="Guilherme Andrade Del Cantoni <guilherme.cantoni@economia.gov.br>"

############################# INÍCIO DA INSTALAÇÃO #############################
ENV MYSQL_ROOT_PASSWORD=root

COPY assets/my.cnf /etc/mysql/my.cnf
COPY assets/my.cnf /etc/mysql/mysql.conf.d/sei.cnf
COPY assets/pre-install.sql /docker-entrypoint-initdb.d/1_pre-install.sql
COPY sei-db-ref-executivo/mysql/v3.1.0/sei_3_1_0_BD_Ref_Exec.sql /docker-entrypoint-initdb.d/2_sei_3_1_0_BD_Ref_Exec.sql
COPY sei-db-ref-executivo/mysql/v3.1.0/sip_3_1_0_BD_Ref_Exec.sql /docker-entrypoint-initdb.d/3_sip_3_1_0_BD_Ref_Exec.sql
COPY assets/pos-install.sql /docker-entrypoint-initdb.d/9_pos-install.sql

RUN chmod 644 /etc/mysql/mysql.conf.d/sei.cnf
RUN sed -i '1i use sei; \n' /docker-entrypoint-initdb.d/2_sei_3_1_0_BD_Ref_Exec.sql
RUN sed -i '1i use sip; \n' /docker-entrypoint-initdb.d/3_sip_3_1_0_BD_Ref_Exec.sql

#RUN ["sed", "-i", "s/exec \"$@\"/echo \"not running $@\"/", "/usr/local/bin/docker-entrypoint.sh"]
#RUN ["/usr/local/bin/docker-entrypoint.sh", "mysqld", "--datadir", "/initialized-db"]
#
#RUN ["/bin/bash", "-c", "chown -R mysql:mysql /initialized-db/"]
#RUN ["/bin/bash", "-c", "chmod ugo=rwx -R /initialized-db/"]
#RUN chmod -R ugo+rwx /initialized-db/ibdata1

############################## FIM DA INSTALAÇÃO ###############################

# CMD ["mysqld"]
# ENTRYPOINT ["/entrypoint.sh"]
# EXPOSE 3306

#FROM mysql:8.0
#COPY --from=builder /initialized-db /var/lib/mysql
