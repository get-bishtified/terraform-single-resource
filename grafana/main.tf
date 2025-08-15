provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

resource "aws_security_group" "grafana_sg" {
  name        = "grafana-sg"
  description = "Allow Grafana and SSH"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [var.allowed_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "grafana" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = element(data.aws_subnets.default.ids, 0)
  vpc_security_group_ids = [aws_security_group.grafana_sg.id]
  key_name               = "shankaz"

  user_data = <<-EOF
#!/bin/bash
# Add Grafana repo
cat <<EOR > /etc/yum.repos.d/grafana.repo
[grafana]
name=Grafana OSS
baseurl=https://packages.grafana.com/oss/rpm
repo_gpgcheck=1
enabled=1
gpgcheck=1
gpgkey=https://packages.grafana.com/gpg.key
EOR

# Install Grafana
yum install -y grafana

# Enable and start Grafana
systemctl enable grafana-server
systemctl start grafana-server

# Provision CloudWatch data source
mkdir -p /etc/grafana/provisioning/datasources
cat <<EOD > /etc/grafana/provisioning/datasources/cloudwatch.yaml
apiVersion: 1
datasources:
  - name: CloudWatch
    type: cloudwatch
    access: proxy
    jsonData:
      authType: default
      defaultRegion: ${var.aws_region}
EOD

# Provision sample dashboard
mkdir -p /etc/grafana/provisioning/dashboards
cat <<EOD > /etc/grafana/provisioning/dashboards/dashboards.yaml
apiVersion: 1
providers:
  - name: 'AWS Dashboards'
    orgId: 1
    folder: 'AWS EC2'
    type: file
    options:
      path: /var/lib/grafana/dashboards
EOD

mkdir -p /var/lib/grafana/dashboards
cat <<EOD > /var/lib/grafana/dashboards/sample-ec2.json
{
  "id": null,
  "title": "EC2 Metrics",
  "tags": ["aws", "ec2"],
  "timezone": "browser",
  "schemaVersion": 16,
  "version": 0
}
EOD

systemctl restart grafana-server
EOF

  tags = {
    Name = "Grafana-EC2"
  }
}
