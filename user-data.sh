#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Welcome to EC2 provisioned for Demo powered by Shankaz.</h1>" > /var/www/html/index.html