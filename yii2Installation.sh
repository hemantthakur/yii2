#!/bin/bash
#################################
#this script is used to install the YII2 on Linux
#author: Hemant thakur
#git: hemantthakur
###############################
if [[ $EUID -ne 0 ]]; then
  echo "Please run this script as ROOT" 2>&1
exit 1
fi
echo "Installing Dependendies on your system";
echo "1> *****************Checking for curl...***********"
crl=`which curl`
if [ ! "$crl"  ];then 
   apt-get install -y curl;
else
   echo "Curl is already Installed";
fi
echo "2>  *****************Checking for php-cli...***********";
req=`which php5`
if [ ! "$req"  ];then
   apt-get install -y php5-cli;
else
   echo "PHP is already in its latest version";
fi
echo "3> *****************Checking for php-mysql...***********";
req=`dpkg -l | grep 'php5-mysql' | awk '{print $2, $3}'`
if [ ! "$req" ];then
	apt-get install -y php5-mysql;
else
	echo "php-sql is already installed on your system";
fi
echo "4> *****************Checking for php-mycrypt...***********";
req=`dpkg -l | grep 'php5-mcrypt' | awk '{print $2, $3}'`
if [ ! "$req" ];then
        apt-get install -y php5-mcrypt;
else
        echo "php-mycrypt is already installed on your system";
fi
echo "5> ***************** Activating Mcrypt. Please wait..... ************ ";
	php5enmod mcrypt;
echo "6> *****************Checking for php5-gd...***********";
req=`dpkg -l | grep 'php5-gd' | awk '{print $2, $3}'`
if [ ! "$req" ];then
        apt-get install -y php5-gd;
else
        echo "php-mycrypt is already installed on your system";
fi
echo "7> ************************ Installing composer *********************";
req=`which composer`
if [ ! "$req" ];then
	curl -sS https://getcomposer.org/installer | php;
else
	echo "Already Installed";
fi
  mv composer.phar /usr/local/bin/composer	
echo "8> *****************Installing Composer Asset Plugins ********";
composer global require "fxp/composer-asset-plugin:1.0.3";
dir='/var/www/html'
dirwww='/var/www'
if [ -d "$dir" ]; then
  cd /var/www/html
elif [ -d "$dirwww" ];then
     cd /var/www;
else
   apt-get install apache2;
   if [ -d "$dir" ]; then
 	 cd /var/www/html
   elif [ -d "$dirwww" ];then
      cd /var/www
   fi
fi
composer create-project --prefer-dist yiisoft/yii2-app-advanced Yii2Advance
cd Yii2Advance
php init 0
echo " ";
echo " ";
echo " ";
echo "****************************************************************";
echo "     Yii2 has been successfully Installed on your system        ";
echo "Open your browser and hit this url: http://localhost/Yii2Advance/frontend/web ";
echo "     Note:  URL IS CASE SENSTIVE  ";
echo "     Thank you for using this script ";
echo "     want to follow me on twitter: @hemant908thakur ";
echo "****************************************************************";
echo " ";
echo " ";
echo " ";

