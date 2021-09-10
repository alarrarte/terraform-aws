#!/bin/bash
yum update -y
yum install httpd -y
echo "HELLO WORLD. INSTANCE created by AWS on host: $HOSTNAME " > /var/www/html/index.html