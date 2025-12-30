#!/bin/bash
set -eux

#######################################
# System update
#######################################
dnf update -y

#######################################
# Install Java 17 (required for Jenkins)
#######################################
dnf install -y java-17-amazon-corretto

#######################################
# Install Git
#######################################
dnf install -y git

#######################################
# Install Docker
#######################################
dnf install -y docker
systemctl enable docker
systemctl start docker

#######################################
# Install Jenkins (creates jenkins user)
#######################################
curl -fsSL https://pkg.jenkins.io/redhat-stable/jenkins.repo \
  -o /etc/yum.repos.d/jenkins.repo

rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

dnf install -y jenkins

#######################################
# Add users to docker group (AFTER install)
#######################################
usermod -aG docker jenkins
usermod -aG docker ec2-user

#######################################
# Start Jenkins
#######################################
systemctl daemon-reexec
systemctl enable jenkins
systemctl start jenkins

#######################################
# Wait for Jenkins to initialize
#######################################
sleep 30

#######################################
# Secure Jenkins (no hardcoded creds)
#######################################
JENKINS_INIT="/var/lib/jenkins/init.groovy.d"
mkdir -p $JENKINS_INIT

cat <<'EOF' > $JENKINS_INIT/security.groovy
#!groovy
import jenkins.model.*
import hudson.security.*

def instance = Jenkins.get()

def realm = new HudsonPrivateSecurityRealm(false)
instance.setSecurityRealm(realm)

def strategy = new FullControlOnceLoggedInAuthorizationStrategy()
strategy.setAllowAnonymousRead(false)
instance.setAuthorizationStrategy(strategy)

instance.save()
EOF

#######################################
# Restart Jenkins to apply security
#######################################
systemctl restart jenkins
