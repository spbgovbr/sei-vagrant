# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Atribuição do hostname da máquina virtual 
  config.vm.hostname = "sei-vagrant"

  config.vm.box = "ubuntu/trusty64"

  # Configuração do redirecionamento entre Máquina Virtual e Host
  # Necessário permissões de root para utilizar a porta 80 (> 1024)
  config.vm.network :forwarded_port, guest: 80,   host: 80   # SIP e SEI (Apache)
  config.vm.network :forwarded_port, guest: 3306, host: 3306 # Banco de Dados (Mysql)
  config.vm.network :forwarded_port, guest: 8080, host: 8080 # Jod Converter (Tomcat)
  config.vm.network :forwarded_port, guest: 8983, host: 8983 # Solr Indexer (Jetty)
  config.vm.network :forwarded_port, guest: 1080, host: 1080 # MailCatcher

  # Diretórios compartilhados com a durante a execução
  config.vm.synced_folder ".", "/mnt/sei/ops" 
  config.vm.synced_folder "../sei", "/opt", mount_options: ["dmode=777", "fmode=777"]

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048", "--usb", "off", "--audio", "none"]
  end

  # Provisionamento da Máquina Virtual responsável por manter os containers do Docker
  #config.vm.provision "docker" do |docker|    
    
    # Constrói imagens dos containers utilizados no provicionamento
#    docker.build_image "/mnt/sei/ops/solr",      args: "-t 'processoeletronico/solr'"
#    docker.build_image "/mnt/sei/ops/mysql",     args: "-t 'processoeletronico/mysql'"
#    docker.build_image "/mnt/sei/ops/sei",       args: "-t 'processoeletronico/sei'"
#    docker.build_image "/mnt/sei/ops/memcached", args: "-t 'processoeletronico/memcached'"
#    docker.pull_images "schickling/mailcatcher"
#    docker.build_image "/mnt/sei/ops/jod",   args: "-t 'processoeletronico/jod'"

    # docker run -d --name smtp -p 1080:1080 schickling/mailcatcher:latest
  #  docker.run "smtp", image: "schickling/mailcatcher",
  #    daemonize: true,
  #    args: "-p 1080:1080"

    # docker run -d --name memcached -p 11211:11211 processoeletronico/memcached:latest
  #  docker.run "memcached", image: "processoeletronico/memcached",
  #    daemonize: true,
  #    args: "-p 11211:11211"

    # docker run -d --name db -p 3306:3306 processoeletronico/mysql:latest
   # docker.run "db",  image: "processoeletronico/mysql:latest", 
   #   daemonize: true, 
   #   args: "-p 3306:3306"

    # docker run -d --name solr -p 8983:8983 -v /mnt/sei/src/sei/solr:/mnt/sei/index processoeletronico/solr:latest
   # docker.run "solr", image: "processoeletronico/solr:latest",
   #   daemonize: true, 
   #   args: "-p 8983:8983"

    # docker run -d --name jod -p 8080:8080 processoeletronico/jod:latest
    #docker.run "jod", image: "processoeletronico/jod:latest",
    #  daemonize: true, 
    #  args: "-p 8080:8080"

    # docker run -d --name sei -p 80:80 --link solr:solr --link db:db --link jod:jod -v /opt:/opt  processoeletronico/sei:latest
  #  docker.run "sei", image: "processoeletronico/sei:latest", 
  #    daemonize: true, 
  #    args: "-p 80:80 --link db:db --link solr:solr --link mencached:memncached--link smtp:smtp -v /opt:/opt"
  #end

  # Inicialização dos containers em caso de reinicialização da máquina host
  # A inicialização é realizada de forma sequencial para evitar conflito no mapeamento de volumes no Docker
 # config.vm.provision "shell", run: "always", inline: "docker restart solr && docker restart memcached && docker restart smtp && docker restart db && docker restart sei"
end
