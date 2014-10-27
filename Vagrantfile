# -*- mode: ruby -*-
# vi: set ft=ruby :
require "yaml"
 
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

# Parâmetros de customização do ambiente de desenvolvimento
params = if File.exists?("Vagrantfile.conf") then YAML::load_file("Vagrantfile.conf") else {} end
params_source_dir = params["source_dir"] || "../sei"
params_script_sei = params["script_sei"] || "../sei-db/sei_2_5_1.sql"
params_script_sip = params["script_sip"] || "../sei-db/sip_2_5_1.sql"
params_memoria_vm = params["memoria_vm"] || "2048"
params_repo_arquivos = params["repositorio_arquivos"] || "../sei-arquivos"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Atribuição do hostname da máquina virtual 
  config.vm.hostname = "sei-vagrant"

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "guilhermeadc/centos65"
  config.vm.box_download_checksum = "1014130dff98564ca18dbf7914c89b46"
  config.vm.box_download_checksum_type = "md5"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  config.vm.box_check_update = true

  # Configuração do redirecionamento entre Máquina Virtual e Host
  # Necessário permissões de root para utilizar a porta 80 (> 1024)
  config.vm.network :forwarded_port, guest: 80, host: 80      # SIP e SEI (Apache)
  config.vm.network :forwarded_port, guest: 3306, host: 3306  # Banco de Dados (Mysql)
  config.vm.network :forwarded_port, guest: 8080,  host: 8080 # Jod Converter (Tomcat)
  config.vm.network :forwarded_port, guest: 8983,  host: 8983 # Solr Indexer (Jetty)

  # Diretórios compartilhados com a durante a execução
  config.vm.synced_folder ".", "/mnt/sei/ops" 
  config.vm.synced_folder params_source_dir, "/mnt/sei/src", mount_options: ["dmode=777", "fmode=777"]
  config.vm.synced_folder params_repo_arquivos, "/mnt/sei/arquivos", create: true, mount_options: ["dmode=777", "fmode=777"]
  config.vm.synced_folder File.dirname(params_script_sei), "/mnt/sei/db_sei" 
  config.vm.synced_folder File.dirname(params_script_sip), "/mnt/sei/db_sip" 

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  config.vm.provider "virtualbox" do |vb|
    # Don't boot with headless mode
    # vb.gui = true
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", params_memoria_vm]
  end

  $script_banco_dados = <<SCRIPT
    mkdir -p /mnt/sei/ops/mysql/.tmp/
    cp /mnt/sei/db_sei/$1 /mnt/sei/ops/mysql/.tmp/sei_mysql.sql
    cp /mnt/sei/db_sip/$2 /mnt/sei/ops/mysql/.tmp/sip_mysql.sql
    cp /mnt/sei/ops/sei/ConfiguracaoSEI.php /mnt/sei/src/sei/ConfiguracaoSEI.php
    cp /mnt/sei/ops/sei/ConfiguracaoSip.php /mnt/sei/src/sip/ConfiguracaoSip.php
SCRIPT

  config.vm.provision "shell", 
    inline: $script_banco_dados, 
    args: [File.basename(params_script_sei), File.basename(params_script_sip)]

  # Provisionamento da Máquina Virtual responsável por manter os containers do Docker
  config.vm.provision "docker" do |docker|    
    
    # Constrói imagens dos containers utilizados no provicionamento
    docker.build_image "/mnt/sei/ops/mysql", args: "-t 'sei.gov/mysql'"
    docker.build_image "/mnt/sei/ops/sei", args: "-t 'sei.gov/sei'"
    docker.build_image "/mnt/sei/ops/solr", args: "-t 'sei.gov/solr'"
    docker.build_image "/mnt/sei/ops/jod", args: "-t 'sei.gov/jod'"

    # Provisiona docker containers na máquina virtual
    # docker run -d --name sei_data -v -v /mnt/sei/arquivos:/var/sei/arquivos centos:centos6 true
    docker.run "sei_data", image: "centos:centos6", 
      daemonize: true, 
      args: "-v /mnt/sei/arquivos:/var/sei/arquivos",
      cmd: "true"

    # docker run -t -i --name sei_db -p 3306:3306 --rm --volumes-from se, "/mnt_data sei.gov/mysql:latest
    docker.run "sei_db",  image: "sei.gov/mysql:latest", 
      daemonize: true, 
      args: "-p 3306:3306"

    # docker run -t -i --name sei_solr -p 8983:8983 --rm -v /mnt/sei/src/sei/solr:/mnt/sei/index sei.gov/solr:latest
    docker.run "sei_solr", image: "sei.gov/solr:latest",
      daemonize: true, 
      args: "-p 8983:8983 -v /mnt/sei/src/sei/solr:/mnt/sei/index"

    # docker run -t -i --name sei_jod -p 8080:8080 --rm sei.gov/jod:latest
    docker.run "sei_jod", image: "sei.gov/jod:latest",
      daemonize: true, 
      args: "-p 8080:8080"

    # docker run -t -i --name sei_www -p 80:80 --rm --link sei_solr:solr --link sei_db:db --link sei_jod:jod -v /mnt/sei/src:/var/www/html sei.gov/sei:latest
    docker.run "sei_www", image: "sei.gov/sei:latest", 
      daemonize: true, 
      args: "-p 80:80 --link sei_db:db --link sei_solr:solr --link sei_jod:jod -v /mnt/sei/src:/var/www/html -v /mnt/sei/ops/sei:/mnt/sei/ops/sei --volumes-from sei_data"
  end

  config.vm.provision "shell", run: "always", inline: "docker start sei_data sei_db sei_solr sei_jod sei_www"
end
