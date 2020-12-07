################################################################################
# Dockerfile de construção do container WebApp utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

#TODO: Migrar para container oficial do PHP 5.6 (5.6-alpine)
FROM centos:centos7
MAINTAINER Guilherme Andrade Del Cantoni <guilherme.cantoni@economia.gov.br>

############################# INÍCIO DA INSTALAÇÃO #############################
ENV TERM xterm

# Arquivos de instalação de componentes do SEI
COPY assets/msttcore-fonts-2.0-3.noarch.rpm /tmp
COPY assets/oracle/oracle-instantclient11.2-basic-11.2.0.4.0-1.x86_64.rpm /tmp/
COPY assets/oracle/oracle-instantclient11.2-devel-11.2.0.4.0-1.x86_64.rpm /tmp/
COPY assets/oracle/oracle-instantclient11.2-sqlplus-11.2.0.4.0-1.x86_64.rpm /tmp/
COPY assets/oracle/install_oracle.sh /tmp/

# Instalação do SEI e demais componentes acessórios
COPY install.sh /install.sh
COPY entrypoint.sh /entrypoint.sh

RUN bash /install.sh

# Configuração dos parâmetros do SEI e SIP
COPY assets/LEIAME.txt /var/www/html/
COPY assets/sei.ini /etc/php.d/sei.ini
COPY assets/xdebug.ini /etc/php.d/xdebug.ini
COPY assets/sei.conf /etc/httpd/conf.d/sei.conf
COPY assets/ConfiguracaoSip.php /ConfiguracaoSip.php
COPY assets/ConfiguracaoSip.mysql.php /ConfiguracaoSip.mysql.php
COPY assets/ConfiguracaoSip.oracle.php /ConfiguracaoSip.oracle.php
COPY assets/ConfiguracaoSip.sqlserver.php /ConfiguracaoSip.sqlserver.php
COPY assets/ConfiguracaoSEI.php /ConfiguracaoSEI.php
COPY assets/ConfiguracaoSEI.mysql.php /ConfiguracaoSEI.mysql.php
COPY assets/ConfiguracaoSEI.oracle.php /ConfiguracaoSEI.oracle.php
COPY assets/ConfiguracaoSEI.sqlserver.php /ConfiguracaoSEI.sqlserver.php

##################### FIM DA INSTALAÇÃO #####################

EXPOSE 80
CMD ["/entrypoint.sh"]
