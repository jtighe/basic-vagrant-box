echo "...WordPress CLI"
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /dev/null 2>&1  
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp > /dev/null 2>&1  
