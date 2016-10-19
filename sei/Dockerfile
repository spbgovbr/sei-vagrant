###########################################################
# Dockerfile de construção do container WebApp utilizado pelo SEI e pelo SIP
############################################################

# Definição da imagem de base para o CentOS 6.X
FROM centos:centos6

# Autor e mantenedor do container
MAINTAINER PEN - Processo Eletrônico Nacional

################## INICIO DA INSTALACAO ######################
# Instalação do SEI seguindo as recomendações descritas na documentação do SEI

ENV TERM xterm

COPY install.sh /install.sh

RUN bash /install.sh

# Configuração dos parâmetros do SEI e SIP
COPY ConfiguracaoSEI.php /ConfiguracaoSEI.php
COPY ConfiguracaoSip.php /ConfiguracaoSip.php

# Copia arquivos necessários para a instalação
COPY sei.ini /etc/php.d/sei.ini
COPY xdebug.ini /etc/php.d/xdebug.ini
COPY sei.conf /etc/httpd/conf.d/sei.conf

# Configuração do Gearman e Supervisor, componentes necessários para a integração do SEI com Processo Eletrônico Nacional
COPY supervisord.conf /etc/supervisord.conf

# Script de inicialização do container entry-point
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

##################### FIM DA INSTALACAO #####################

# Exposição da porta de conexão ao Apache
EXPOSE 80

# Inicialização dos serviços Apache e Memcache
CMD ["/entrypoint.sh"]

