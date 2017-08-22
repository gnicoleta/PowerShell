#!/bin/bash
set -e
[ `whoami` = root ] || { sudo "$0" "$@"; exit $?; }

wget https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-beta.2/powershell_6.0.0-beta.2-1ubuntu1.16.04.1_amd64.deb
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -
curl https://packages.microsoft.com/config/ubuntu/14.04/prod.list | tee /etc/apt/sources.list.d/microsoft.list
apt-get -y update

wget http://launchpadlibrarian.net/201330288/libicu52_52.1-8_amd64.deb
dpkg -i libicu52_52.1-8_amd64.deb

apt-get -fy install
apt-get -y install powershell
apt-get -y remove powershell
ls | grep powershell | xargs dpkg -i


sudo apt-get install -y omi
sudo apt-get install -y omi-psrp-server

sed -i -e "s/\(httpport=\).*/\15985/; s/\(httpsport=\).*/\15986/" /etc/opt/omi/conf/omiserver.conf

/opt/omi/bin/omiserver -s
/opt/omi/bin/omiserver -d
