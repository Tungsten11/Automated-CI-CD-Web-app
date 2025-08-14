output "instance_id" {
  value = aws_instance.web-server.id
}

output "public_ip" {
  value       = aws_instance.web-server.id
  description = "Public IP of the monitoring EC2 instance"
}


