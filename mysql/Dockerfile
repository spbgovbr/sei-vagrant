################################################################################
# Dockerfile de construção do container do MySQL utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

FROM mariadb:10.5 as builder

############################# INÍCIO DA INSTALAÇÃO #############################
ENV MYSQL_ROOT_PASSWORD=P@ssword

COPY assets/my.cnf /etc/mysql/mariadb.conf.d/sei.cnf
COPY assets/pre-install.sql /docker-entrypoint-initdb.d/1_pre-install.sql
COPY sei-db-ref-executivo/mysql/v4.0.0/sei_4_0_0_BD_Ref_Exec.sql /docker-entrypoint-initdb.d/2_sei_4_0_0_BD_Ref_Exec.sql
COPY sei-db-ref-executivo/mysql/v4.0.0/sip_4_0_0_BD_Ref_Exec.sql /docker-entrypoint-initdb.d/3_sip_4_0_0_BD_Ref_Exec.sql
COPY assets/pos-install.sql /docker-entrypoint-initdb.d/9_pos-install.sql

RUN chmod 644 /etc/mysql/mariadb.conf.d/sei.cnf
RUN sed -i '1i use sei; \n' /docker-entrypoint-initdb.d/2_sei_4_0_0_BD_Ref_Exec.sql
RUN sed -i '1i use sip; \n' /docker-entrypoint-initdb.d/3_sip_4_0_0_BD_Ref_Exec.sql

RUN ["sed", "-i", "s/exec \"$@\"/echo \"not running $@\"/", "/usr/local/bin/docker-entrypoint.sh"]
RUN ["/usr/local/bin/docker-entrypoint.sh", "mysqld", "--datadir", "/initialized-db"]

# Instalação do SEI e demais componentes acessórios
# COPY install.sh /install.sh
# RUN bash /install.sh

############################## FIM DA INSTALAÇÃO ###########################
FROM mariadb:10.5
COPY --from=builder /initialized-db /var/lib/mysql
COPY --from=builder /etc/mysql/mariadb.conf.d/sei.cnf /etc/mysql/mariadb.conf.d/sei.cnf