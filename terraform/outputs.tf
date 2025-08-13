output "instance_ip" {
  value = aws_instance.monitoring_ec2.public_ip
}

output "grafana_url" {
  value = "http://${aws_instance.monitoring_ec2.public_ip}:3000"
}

output "prometheus_url" {
  value = "http://${aws_instance.monitoring_ec2.public_ip}:9090"
}
