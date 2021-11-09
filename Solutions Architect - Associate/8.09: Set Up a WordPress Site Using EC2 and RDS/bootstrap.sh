#!/bin/bash
sudo su - root
yum -y update

# MySQL

yum -y install mysql

# Web server

echo "<h1> My web server!! </h1>" >> /var/www/html/index.html
yum -y install httpd
service httpd start

# Wordpress
