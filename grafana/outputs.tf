output "grafana_instance_public_ip" {
  description = "Public IP of the Grafana EC2 instance"
  value       = aws_instance.grafana.public_ip
}

output "grafana_url" {
  description = "Grafana URL for browser access"
  value       = "http://${aws_instance.grafana.public_ip}:3000"
}
