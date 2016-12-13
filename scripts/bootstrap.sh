#!/usr/bin/env bash

# Assign Args
php_version=${1}

# Clear the Screen
printf "\033c"

# Read User Configuration
source /vagrant/config.sh

if [ ! -f /home/vagrant/.provisioned ]
  then
    echo "----------------------------------------"
    echo "Provisioning Vagrant Box"
    echo "----------------------------------------"

    source /vagrant/scripts/basic-provisioning.sh

    echo "----------------------------------------"
    echo "Provisioning Complete"
    echo "----------------------------------------"

    # Include Custom Provisioning
    if [ -f /vagrant/custom/provisioning.sh ]
      then
        echo "----------------------------------------"
        echo "Custom Provisioning"
        echo "----------------------------------------"
        source /vagrant/custom/provisioning.sh
        echo "----------------------------------------"
        echo "Custom Provisioning Complete"
        echo "----------------------------------------"
    fi
    
    # Create Link for custom Initialization
    ln -s /vagrant/scripts/initialize.sh /usr/local/bin/initialize
    
    # Set a flag(s)
    touch /home/vagrant/.provisioned
    touch /home/vagrant/.php${php_version}
    
fi

echo " "
echo "Restarting Apache Server"
sudo service apache2 restart  > /dev/null 2>&1
echo " "
echo 'Please SSH into the vagrant box'
echo '  $ vagrant ssh'
echo 'and initialize it.'
echo '  $ initialize'