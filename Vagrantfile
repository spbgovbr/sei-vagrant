# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  ## Instalação de plugin para configuração automática do disco
  required_plugins = %w( vagrant-vbguest vagrant-disksize )
  _retry = false
  required_plugins.each do |plugin|
    unless Vagrant.has_plugin? plugin
      system "vagrant plugin install #{plugin}"
      _retry=true
    end
  end

  if (_retry)
    exec "vagrant " + ARGV.join(' ')
  end

  # Atribuição do hostname da máquina virtual
  config.vm.hostname = "sei-vagrant"
  config.vm.box = "centos/8"

  #config.ssh.username = "vagrant"
  #config.ssh.password = "vagrant"

  config.vbguest.auto_update = true
  config.vbguest.no_remote = false
  config.vbguest.iso_mount_point = "/media"
  config.vbguest.installer_options = { allow_kernel_upgrade: true }

  # Configuração do redirecionamento entre Máquina Virtual e Host
  # Necessário permissões de root para utilizar a porta 80 (> 1024)
  config.vm.network :forwarded_port, guest: 80,   host: 80   # SIP e SEI (Apache)
  config.vm.network :forwarded_port, guest: 1521, host: 1521 # Banco de Dados (Oracle)
  config.vm.network :forwarded_port, guest: 1433, host: 1433 # Banco de Dados (SQL Server)
  config.vm.network :forwarded_port, guest: 3306, host: 3306 # Banco de Dados (Mysql)
  config.vm.network :forwarded_port, guest: 8080, host: 8080 # Jod Converter (Tomcat)
  config.vm.network :forwarded_port, guest: 8983, host: 8983 # Solr Indexer (Jetty)
  config.vm.network :forwarded_port, guest: 1080, host: 1080 # MailCatcher

  # Diretórios compartilhados com a durante a execução
  config.vm.synced_folder ".", "/mnt/sei/ops"
  config.vm.synced_folder "../sei", "/mnt/sei/src", mount_options: ["dmode=777", "fmode=777"]

  # Configurações padrão da máquina virtual host
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--memory", "4096", "--usb", "off", "--audio", "none"]
  end

  # Provisionamento da máquina virtual responsável por manter os containers do Docker
  config.vm.provision "docker" do |docker|
    docker.pull_images "guilhermeadc/sei3_solr-6.1"
    docker.pull_images "guilhermeadc/sei3_mysql-5.7"
    docker.pull_images "guilhermeadc/sei3_jod-2.2.2"
    docker.pull_images "guilhermeadc/sei3_httpd-2.4"
    docker.pull_images "guilhermeadc/sei3_mailcatcher"
    docker.pull_images "guilhermeadc/sei3_memcached"
  end

  $script = <<-'SCRIPT'
    sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
SCRIPT

  config.vm.provision "shell", inline: $script
  config.vm.provision "shell", run: "always", inline: "/usr/local/bin/docker-compose -f /docker-compose.yml up -d"
end
