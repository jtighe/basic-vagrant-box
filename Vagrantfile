# -*- mode: ruby -*-
# vi: set ft=ruby :

#$php_version = '5'  
$php_version = '7.0'
$box_name = "wwwPHP7 - LAMP - PHP #{$php_version} - 2016-11-08"
$cpus = 1
$memory = 4096
$vagrant_ip = "10.6.6.66"

Vagrant.configure(2) do |config|

  if $php_version == '5'
    config.vm.box = "ubuntu/trusty64"
  else
    config.vm.box = "bento/ubuntu-16.04"
  end

  config.vm.provider "virtualbox" do |vb|
     vb.name = $box_name
     vb.cpus = $cpus
     vb.memory = $memory
     vb.gui = false
  end

  config.vm.network "private_network", ip: $vagrant_ip

  # Setup shared folders
  config.vm.synced_folder "./wwwSites", "/var/www", :group => "www-data", :mount_options => ['dmode=775','fmode=664']

  #config.vm.synced_folder "./wwwSites", "/var/www", type: :nfs
  #config.bindfs.bind_folder "/var/www", "/var/www"

  config.ssh.forward_agent = true

  # Fix for: "stdin: is not a tty"
  # https://github.com/mitchellh/vagrant/issues/1673#issuecomment-28288042
  config.ssh.shell = %{bash -c 'BASH_ENV=/etc/profile exec bash'}

  # This is the shell configuration for the vagrant box
  config.vm.provision "shell" do |s|
    s.path = "./scripts/bootstrap.sh"
    s.args = "#{$php_version}"
  end
end
