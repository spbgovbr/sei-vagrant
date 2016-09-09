# -*- mode: ruby -*-
# vi: set ft=ruby :
require "yaml"
 
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Parâmetros de customização do ambiente de desenvolvimento
params = if File.exists?("Vagrantfile.conf") then YAML::load_file("Vagrantfile.conf") else {} end
params_source_dir = params["source_dir"] || "../sei"
#params_script_sei = params["script_sei"] || "../sei-db-ref-executivo/mysql/sei_2_6_0_BD_Ref_Exec.sql"
#params_script_sip = params["script_sip"] || "../sei-db-ref-executivo/mysql/sip_2_6_0_BD_Ref_Exec.sql"
params_memoria_vm = params["memoria_vm"] || "1024"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Atribuição do hostname da máquina virtual 
  config.vm.hostname = "sei-vagrant"

  # Every Vagrant virtual environment requires a box to build off of.
  # config.vm.box_download_checksum = "76a2a61de2d89f6cfd4d795e57cc4406"
  # config.vm.box_download_checksum_type = "md5"
  # config.vm.box = "minimum/centos-7-docker"
  # config.vm.box = "centos/7"
  config.vm.box = "ubuntu/trusty64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = true

  # Configuração do redirecionamento entre Máquina Virtual e Host
  # Necessário permissões de root para utilizar a porta 80 (> 1024)
  config.vm.network :forwarded_port, guest: 80,   host: 80   # SIP e SEI (Apache)
  config.vm.network :forwarded_port, guest: 3306, host: 3306 # Banco de Dados (Mysql)
  config.vm.network :forwarded_port, guest: 8080, host: 8080 # Jod Converter (Tomcat)
  config.vm.network :forwarded_port, guest: 8983, host: 8983 # Solr Indexer (Jetty)

  # Diretórios compartilhados com a durante a execução
  config.vm.synced_folder ".", "/mnt/sei/ops" 
  config.vm.synced_folder params_source_dir, "/mnt/sei/src", mount_options: ["dmode=777", "fmode=777"]
 # config.vm.synced_folder File.dirname(params_script_sei), "/mnt/sei/db_sei" 
 # config.vm.synced_folder File.dirname(params_script_sip), "/mnt/sei/db_sip" 

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider "virtualbox" do |vb|
    # Don't boot with headless mode
    # vb.gui = true
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", params_memoria_vm, "--usb", "off", "--audio", "none"]
  end

  config.vm.provision "shell", 
    #args: [File.basename(params_script_sei), File.basename(params_script_sip)],
    inline: <<SCRIPT
      mkdir -p /mnt/sei/ops/mysql/.tmp/
      #cp /mnt/sei/db_sei/$1 /mnt/sei/ops/mysql/.tmp/sei_mysql.sql
      #cp /mnt/sei/db_sip/$2 /mnt/sei/ops/mysql/.tmp/sip_mysql.sql
      cp /mnt/sei/ops/sei/ConfiguracaoSEI.php /mnt/sei/src/sei/ConfiguracaoSEI.php
      cp /mnt/sei/ops/sei/ConfiguracaoSip.php /mnt/sei/src/sip/ConfiguracaoSip.php
SCRIPT

  # Provisionamento da Máquina Virtual responsável por manter os containers do Docker
  config.vm.provision "docker" do |docker|    
    
    # Constrói imagens dos containers utilizados no provicionamento
    docker.build_image "/mnt/sei/ops/solr",  args: "-t 'processoeletronico/solr'"
    docker.build_image "/mnt/sei/ops/mysql", args: "-t 'processoeletronico/mysql'"
    docker.build_image "/mnt/sei/ops/sei",   args: "-t 'processoeletronico/sei'"
    docker.build_image "/mnt/sei/ops/jod",   args: "-t 'processoeletronico/jod'"

    # Provisiona docker containers na máquina virtual
    # docker run -it --name sei_data -v /mnt/sei/arquivos:/var/sei/arquivos centos:centos6 true
    # docker.run "sei_data", image: "centos:centos6", 
    #   args: "-v /mnt/sei/arquivos:/var/sei/arquivos",
    #   cmd: "true"

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
      args: "-p 80:80 --link sei_db:db --link sei_solr:solr --link sei_jod:jod -v /mnt/sei/src:/mnt/sei/src"
  end

  # Limpeza de arquivos temporários criados durante o provisionamento do sistema
  # config.vm.provision "shell", inline: "rm -rf /mnt/sei/ops/mysql/.tmp"

  # Inicialização dos containers em caso de reinicialização da máquina host
  # A inicialização é realizada de forma sequencial para evitar conflito no mapeamento de volumes no Docker
  config.vm.provision "shell", run: "always", inline: "docker restart sei_solr && docker restart sei_jod && docker restart sei_db && docker restart sei_www"
end
