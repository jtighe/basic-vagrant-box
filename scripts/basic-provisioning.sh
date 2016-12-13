echo "Updating Operating System with PHP version ${php_version}"
sudo apt-get update > /dev/null 2>&1
echo "...add Package: curl"
sudo apt-get install -y curl > /dev/null 2>&1
echo "...add Package: unzip"
sudo apt-get install unzip  > /dev/null 2>&1
echo "...add Package: memcached"
sudo apt-get install -y memcached > /dev/null 2>&1
echo "...add Package: mcrypt"
sudo apt-get install -y mcrypt > /dev/null 2>&1

echo "Installing"
echo "...Apache"
sudo apt-get install -y apache2 > /dev/null 2>&1
echo "......Module: SSL"
sudo a2enmod ssl > /dev/null 2>&1
echo "......Module: rewrite"
sudo a2enmod rewrite > /dev/null 2>&1

echo "...MySQL"
echo "..........User: root"
echo "......Password: vagrant"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password vagrant"
sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password vagrant"
sudo apt-get -y install mysql-server > /dev/null 2>&1

echo "...PHP"
if [ $php_version != "7.0" ]
  then		
    sudo apt-get install -y php5 > /dev/null 2>&1
    echo "......Module: mysql"
    sudo apt-get install "php5-mysql" > /dev/null 2>&1  
    echo "......Module: libapache2"
    sudo apt-get install -y libapache2-mod-php5 > /dev/null 2>&1
    echo "......Module: mysql"
    sudo apt-get install -y php5-mysql > /dev/null 2>&1
    echo "......Module: curl"
    sudo apt-get install -y php5-curl > /dev/null 2>&1
    echo "......Module: mcrypt"
    sudo apt-get install -y php5-mcrypt > /dev/null 2>&1
    #echo "......Module: mbstring"
    #sudo apt-get install -y php5-mbstring > /dev/null 2>&1
    echo "......Module: memcached"
    sudo apt-get install -y php5-memcached > /dev/null 2>&1
    echo "......Module: xdebug"
    sudo apt-get install -y php5-xdebug > /dev/null 2>&1
  else
    sudo apt-get install -y php7.0 > /dev/null 2>&1
    echo "......Module: mysql"
    sudo apt-get install "php7.0-mysql" > /dev/null 2>&1  
    echo "......Module: libapache2"
    sudo apt-get install -y libapache2-mod-php7.0 > /dev/null 2>&1
    echo "......Module: mysql"
    sudo apt-get install -y php7.0-mysql > /dev/null 2>&1
    echo "......Module: curl"
    sudo apt-get install -y php7.0-curl > /dev/null 2>&1
    echo "......Module: mcrypt"
    sudo apt-get install -y php7.0-mcrypt > /dev/null 2>&1
    #echo "......Module: mbstring"
    #sudo apt-get install -y php7.0-mbstring > /dev/null 2>&1
    echo "......Module: memcached"
    sudo apt-get install -y php-memcached > /dev/null 2>&1
    echo "......Module: xdebug"
    sudo apt-get install -y php-xdebug > /dev/null 2>&1
fi  

echo "...PHPAdmin"
echo "..........User: root"
echo "......Password: vagrant"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password vagrant"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password vagrant"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password vagrant"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get -y install phpmyadmin > /dev/null 2>&1  

echo "...Git"
sudo apt-get install git -y > /dev/null 2>&1  
git config --global user.name "${first_name} ${last_name}"
git config --global user.email ${email_address}
echo "......User: ${first_name} ${last_name}"
echo "......EMail: ${email_address}"

for Repo in "${Git_Repo_List[@]}";
  do
    repo_user_name=${Git_Repo_Details["${Repo}","user_name"]}
    repo_private_key_file_name=${Git_Repo_Details["${Repo}","private_key_file_name"]}
    
    echo "......${Repo}"
    echo "............user: ${repo_user_name}"
    echo "........key name: ${repo_private_key_file_name}"
    if [ -f "/vagrant/${repo_private_key_file_name}" ]
	    then		
        sudo mv /vagrant/${repo_private_key_file_name} /home/vagrant/.ssh/${repo_private_key_file_name}  
        sudo chmod 400 /home/vagrant/.ssh/${repo_private_key_file_name}
	      echo ".......key_file: ${repo_private_key_file_name} ...moved"
	    else
	      echo ".......key_file: NOT FOUND"   	
    fi
    sudo echo "Host ${Repo}" >> /home/vagrant/.ssh/config
    sudo echo "User ${repo_user_name}" >> /home/vagrant/.ssh/config
    sudo echo "IdentityFile ~/.ssh/${repo_private_key_file_name}" >> /home/vagrant/.ssh/config
    echo ".........Id file: created"
done

echo "...Composer"
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer > /dev/null 2>&1  
