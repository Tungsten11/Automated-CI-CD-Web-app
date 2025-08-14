output "instance_id" {
  value = aws_instance.monitoring_ec2.id
}

output "public_ip" {
  value       = aws_instance.monitoring_ec2.public_ip
  description = "Public IP of the monitoring EC2 instance"
}


