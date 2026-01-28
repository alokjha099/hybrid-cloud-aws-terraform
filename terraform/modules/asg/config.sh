#!/bin/bash
set -e

echo "===== Initializing Java Application Server (Joget PoC) ====="


TEMPDIR="/tmp/webfiles"
SVC_APACHE="apache2"
SVC_TOMCAT="tomcat9"


apt update -y


apt install -y apache2 wget unzip openjdk-11-jdk tomcat9


systemctl enable $SVC_APACHE
systemctl start $SVC_APACHE

systemctl enable $SVC_TOMCAT
systemctl start $SVC_TOMCAT


a2enmod proxy proxy_http

cat <<EOF >/etc/apache2/sites-available/000-default.conf
<VirtualHost *:80>
    ProxyPreserveHost On
    ProxyPass / http://localhost:8080/
    ProxyPassReverse / http://localhost:8080/
</VirtualHost>
EOF

systemctl restart apache2


cat  <<EOF >/var/lib/tomcat9/webapps/ROOT/index.html
<html>
  <head><title>Joget PoC</title></head>
  <body>
    <h1>Joget Java Application Server</h1>
    <p>This EC2 instance runs Tomcat with Java.</p>
    <p>In production, the Joget WAR file would be deployed here.</p>
  </body>
</html>
EOF

chown -R tomcat:tomcat /var/lib/tomcat9/webapps

echo "===== Joget Java Application Server Setup Complete ====="
