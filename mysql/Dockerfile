################################################################################
# Dockerfile de construção do container do MySQL utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

FROM mysql:8
MAINTAINER Guilherme Andrade Del Cantoni <guilherme.cantoni@planejamento.gov.br>

############################# INÍCIO DA INSTALAÇÃO #############################
#ENV TERM xterm
ENV MYSQL_ROOT_PASSWORD=root

COPY assets/pre-install.sql /docker-entrypoint-initdb.d/1_pre-install.sql
COPY sei-db-ref-executivo/mysql/sei_3_0_0_BD_Ref_Exec.sql /docker-entrypoint-initdb.d/2_sei_3_0_0_BD_Ref_Exec.sql
COPY sei-db-ref-executivo/mysql/sip_3_0_0_BD_Ref_Exec.sql /docker-entrypoint-initdb.d/3_sip_3_0_0_BD_Ref_Exec.sql
COPY assets/pos-install.sql /docker-entrypoint-initdb.d/9_pos-install.sql
COPY assets/my.cnf /etc/mysql/conf.d/sei.cnf
#COPY install.sh /install.sh
#COPY entrypoint.sh /entrypoint.sh


#RUN sh /install.sh
############################## FIM DA INSTALAÇÃO ###############################

#EXPOSE 3306
#CMD ["/entrypoint.sh"]
#CMD ["--default-authentication-plugin=mysql_native_password"]

ENTRYPOINT ["/entrypoint.sh"]
HEALTHCHECK CMD /healthcheck.sh
EXPOSE 3306 33060
CMD ["mysqld"]