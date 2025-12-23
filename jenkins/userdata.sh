#!/bin/bash
set -e
yum update -y

# Install Java 17 (Best for Jenkins)
yum install java-17-amazon-corretto -y

# Jenkins repo + key
wget -O /etc/yum.repos.d/jenkins.repo \
https://pkg.jenkins.io/redhat-stable/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# Install Jenkins
yum install jenkins -y

# Start Jenkins
systemctl daemon-reload
systemctl enable jenkins
systemctl start jenkins
