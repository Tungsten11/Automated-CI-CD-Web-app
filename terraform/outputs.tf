output "ec2_public_ip" {
  value = module.monitoring_ec2.public_ip
}

output "grafana_url" {
  value = "http://${module.monitoring_ec2.public_ip}:3000"
}

output "prometheus_url" {
  value = "http://${module.monitoring_ec2.public_ip}:9090"
}
