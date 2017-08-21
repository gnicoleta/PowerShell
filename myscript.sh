#!/bin/bash

wget https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-beta.2/powershell_6.0.0-beta.2-1ubuntu1.16.04.1_amd64.deb
ls | grep deb | xargs dpkg -i

sed -i -e "s/\(httpport=\).*/\1585/; s/\(httpsport=\).*/\15986/" /etc/opt/omi/conf/omiserver.conf

/opt/omi/bin/omiserver -s
/opt/omi/bin/omiserver -d
