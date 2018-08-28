#/bin/bash
yum -y install httpd httpd-devel
echo "httpd installed"
yum -y install epel-release
echo "epel installed"
yum -y install wget
if [ ! -f "webtatic-release.rpm" ];then
wget http://repo.webtatic.com/yum/el7/webtatic-release.rpm
fi
yum -y install openssl openssl-libs mod-ssl
rpm -ivh webtatic-release.rpm
yum -y install php71w php71w-gd php71w-mysqlnd php71w-mbstring php71w-bcmath php71w-curl php71w-devel php71w-pdo php71w-pdo_dblib php71w-pear php71w-pecl-igbinary php71w-xml php71w-pecl-redis php71w-process
if [ ! -f "/etc/yum.repos.d/mssqlrelease.repo" ];then
curl https://packages.microsoft.com/config/rhel/7/prod.repo > /etc/yum.repos.d/mssqlrelease.repo
fi
yum -y install msodbcsql mssql-tools unixODBC-devel
yum -y install gcc glibc-headers gcc-c++
if [ ! -f "pdo_sqlsrv-5.3.0.tgz" ];then
wget http://pecl.php.net/get/pdo_sqlsrv-5.3.0.tgz
fi
tar zxvf pdo_sqlsrv-5.3.0.tgz
cd pdo_sqlsrv-5.3.0
/usr/bin/phpize
./configure --with-php-config=/usr/bin/php-config
make && make install
sed -i '$a extension=pdo_sqlsrv.so' /etc/php.d/pdo.ini
service httpd restart
