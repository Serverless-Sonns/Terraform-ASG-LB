#!/bin/bash
sudo yum update
sudo yum install -y httpd
sudo echo "<h1> hello pari pornam </h1>" > /var/www/html/index.html
sudo systemctl start httpd