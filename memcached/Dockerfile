##############################################################################
# Dockerfile de construção do container WebApp utilizado pelo SEI e pelo SIP #
##############################################################################

# Definição da imagem de base para o CentOS 6.X
FROM memcached

# Autor e mantenedor do container
MAINTAINER PEN - Processo Eletrônico Nacional

# Definição do terminal a ser utilizado
ENV TERM xterm





# Exposição da porta de conexão ao Apache
EXPOSE 11211

# Inicialização dos serviços Apache e Memcache
CMD ["/entrypoint.sh"]

