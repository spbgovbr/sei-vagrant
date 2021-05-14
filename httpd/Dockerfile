################################################################################
# Dockerfile de construção do container WebApp utilizado pelo SEI e pelo SIP
#
# Container preparado e configurado para uso em desenvolvimento e testes
################################################################################

FROM centos:centos7

############################# INÍCIO DA INSTALAÇÃO #############################
ENV TERM xterm

# Arquivos de instalação de componentes do SEI
COPY assets/msttcore-fonts-2.0-3.noarch.rpm /tmp
COPY assets/uploadprogress/ /tmp
COPY assets/oracle/oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm /tmp/
COPY assets/oracle/oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm /tmp/
COPY assets/oracle/oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm /tmp/
COPY assets/oracle/install_oracle.sh /tmp/

# Instalação do SEI e demais componentes acessórios
COPY install.sh /install.sh
COPY entrypoint.sh /entrypoint.sh

RUN bash /install.sh

# Configurações gerais dos componentes do servidor
COPY assets/info.php /var/www/html/info.php
COPY assets/php.ini /etc/php.d/sei.ini
COPY assets/httpd.conf /etc/httpd/conf.d/sei.conf
COPY assets/cron.conf /etc/cron.d/sei
COPY assets/xdebug.ini /etc/php.d/xdebug.ini

# Configuração dos parâmetros do SEI e SIP
COPY assets/ConfiguracaoSip.php /ConfiguracaoSip.php
COPY assets/ConfiguracaoSEI.php /ConfiguracaoSEI.php

##################### FIM DA INSTALAÇÃO #####################

EXPOSE 8000
CMD ["/entrypoint.sh"]
