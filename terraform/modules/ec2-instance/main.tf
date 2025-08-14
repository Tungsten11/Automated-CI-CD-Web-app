resource "aws_instance" "web-server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.security_groups

  user_data = var.user_data

  root_block_device {
    volume_size = 20 # size in GB
    volume_type = "gp3"
  }

  tags = {
    Name = var.name
  }
}
