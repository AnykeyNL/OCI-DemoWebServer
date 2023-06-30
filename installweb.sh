#!/bin/bash
echo Running installweb script
echo Detecting OS
os=$(awk -F= '/PRETTY_NAME/{print $2}' /etc/os-release)

if [[ $os == *"Ubuntu"* ]]; then
 echo ==  Installing Web Server on Ubuntu
 echo .
 sudo apt -y update
 sudo apt install -y vim git
 sudo apt install -y dialog
 sudo apt install -y apache2
 sudo apt install -y iptables-persistent
 sudo iptables -F
 sudo netfilter-persistent save
 sudo DEBIAN_FRONTEND=noninteractive apt install -y tzdata
 if [[ $os == *"18"* ]]; then
  sudo apt install -y php7.2 libapache2-mod-php7.2
 fi
 if [[ $os == *"20"* ]]; then
  sudo apt install -y php7.4 libapache2-mod-php7.4
 fi

fi
if [[ $os == *"Oracle"* ]]; then
 echo ==  Installing Web Server on Oracle
 echo .
 echo = install httpd
 sudo yum -y install httpd
 echo = enabling http
 sudo systemctl enable httpd
 echo = restarting httpd
 sudo systemctl restart httpd
 echo = config firewall
 #sudo firewall-cmd --permanent --add-port=80/tcp
 sudo firewall-offline-cmd --add-port=80/tcp
 echo = enabling firewall
 #sudo firewall-cmd --reload
 sudo systemctl enable firewalld
 echo = starting firewall
 sudo systemctl start firewalld
 echo = download latest epel
 sudo yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
 echo = install remi rpm
 sudo yum -y install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
 echo = install yum utils
 sudo yum -y install yum-utils
 echo = enabling remi-php
 sudo yum-config-manager --enable remi-php74
 echo = yum updating
 sudo yum -y update --skip-broken --nobest
 echo = installing php components
 sudo yum -y install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
 echo = restarting webserver
 sudo systemctl restart httpd
 echo = small delay....
 sleep 10
 echo = retry restarting firewall
 sudo systemctl restart firewalld

fi

echo = Installing web pages
sudo wget https://www.oci-workshop.com/oci.html --no-check-certificate -O /var/www/html/index.php
echo = download stress script
sudo wget http://www.oci-workshop.com/stress.txt --no-check-certificate -O stress.php
echo = Remove default html page
sudo rm /var/www/html/index.html


#clear
echo =============================
echo ==  Web Server Installed   ==
echo =============================
echo .