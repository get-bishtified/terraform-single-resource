#!/bin/bash
set -euxo pipefail

# Log everything for debugging
exec > >(tee /var/log/user-data.log | logger -t user-data -s 2>/dev/console) 2>&1

echo "===== USERDATA START ====="

echo "=== OS INFO ==="
cat /etc/os-release

echo "=== Update system ==="
dnf update -y

echo "=== Install base utilities (avoid curl conflict) ==="
dnf install -y git unzip shadow-utils dnf-plugins-core

echo "=== Install Java 17 (Amazon Corretto) ==="
dnf install -y java-17-amazon-corretto

echo "=== Install Docker ==="
dnf install -y docker
systemctl enable docker
systemctl start docker

echo "=== Add Jenkins repo ==="
curl -fsSL https://pkg.jenkins.io/redhat-stable/jenkins.repo \
  -o /etc/yum.repos.d/jenkins.repo

echo "=== Import Jenkins GPG key ==="
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

echo "=== Install Jenkins ==="
dnf install -y jenkins

echo "=== Add Jenkins user to docker group ==="
usermod -aG docker jenkins

echo "=== Start Jenkins ==="
systemctl daemon-reexec
systemctl enable jenkins
systemctl start jenkins

echo "===== USERDATA COMPLETE ====="
