# -*- mode: ruby -*-
# vi: set ft=ruby :

#unless Vagrant.has_plugin?("vagrant-vbguest")
#  raise "\n\nAmbiente de desenvolvimento não pode ser criado não foi encontrado o plugin vagrant-vbguest.\n"+
#	"Para solucionar o problema, execute o seguinte comando no diretório raiz do projeto.\n\n"+
#	"> vagrant plugin install vagrant-vbguest \n\n"
#end
 
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
  config.vm.synced_folder "../sei", "/mnt/sei/src", mount_options: ["dmode=777", "fmode=777"]

  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "2048", "--usb", "off", "--audio", "none"]
  end

#  config.vm.provision "shell", 
#    inline: <<SCRIPT
#      mkdir -p /mnt/sei/ops/mysql/.tmp/
#      cp /mnt/sei/ops/sei/ConfiguracaoSEI.php /mnt/sei/src/sei/ConfiguracaoSEI.php
#      cp /mnt/sei/ops/sei/ConfiguracaoSip.php /mnt/sei/src/sip/ConfiguracaoSip.php
#SCRIPT

  # Provisionamento da Máquina Virtual responsável por manter os containers do Docker
  config.vm.provision "docker" do |docker|    
    
    # Constrói imagens dos containers utilizados no provicionamento
    docker.build_image "/mnt/sei/ops/solr",  args: "-t 'processoeletronico/solr'"
    docker.build_image "/mnt/sei/ops/mysql", args: "-t 'processoeletronico/mysql'"
    docker.build_image "/mnt/sei/ops/sei",   args: "-t 'processoeletronico/sei'"
    docker.build_image "/mnt/sei/ops/jod",   args: "-t 'processoeletronico/jod'"
    docker.pull_images "schickling/mailcatcher"

    docker.run "sei_smtp", image: "schickling/mailcatcher",
      daemonize: true,
      args: "-p 1080:1080"

    # docker run -d --name sei_db -p 3306:3306 processoeletronico/mysql:latest
    docker.run "sei_db",  image: "processoeletronico/mysql:latest", 
      daemonize: true, 
      args: "-p 3306:3306"

    # docker run -d --name sei_solr -p 8983:8983 -v /mnt/sei/src/sei/solr:/mnt/sei/index processoeletronico/solr:latest
    docker.run "sei_solr", image: "processoeletronico/solr:latest",
      daemonize: true, 
      args: "-p 8983:8983 -v /mnt/sei/src/sei/solr:/mnt/sei/index"

    # docker run -d --name sei_jod -p 8080:8080 processoeletronico/jod:latest
    docker.run "sei_jod", image: "processoeletronico/jod:latest",
      daemonize: true, 
      args: "-p 8080:8080"

    # docker run -d --name sei_www -p 80:80 --link sei_solr:solr --link sei_db:db --link sei_jod:jod -v /mnt/sei/src:/mnt/sei/src  processoeletronico/sei:latest
    docker.run "sei_www", image: "processoeletronico/sei:latest", 
      daemonize: true, 
      args: "-p 80:80 --link sei_db:db --link sei_solr:solr --link sei_jod:jod --link sei_smtp:smtp -v /mnt/sei/src:/mnt/sei/src"
  end

  # Inicialização dos containers em caso de reinicialização da máquina host
  # A inicialização é realizada de forma sequencial para evitar conflito no mapeamento de volumes no Docker
  config.vm.provision "shell", run: "always", inline: "docker restart sei_solr && docker restart sei_jod && docker restart sei_smtp && docker restart sei_db && docker restart sei_www"
end
