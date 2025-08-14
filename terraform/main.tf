terraform {
  backend "s3" {
    bucket         = "my-cicd-state-flask-bucket1"
    key            = "dev/terraform.tfstate"
    region         = "ap-southeast-1"
    dynamodb_table = "tf-state-locking-cicd"
    encrypt        = true
  }
}

provider "aws" {
  region = "ap-southeast-1"
}


# Fetch your public IP
data "http" "my_ip" {
  url = "https://checkip.amazonaws.com"
}

locals {
  my_ip = chomp(data.http.my_ip.response_body) # remove newline
}

# Latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# Security Group Module
module "monitoring_sg" {
  source      = "./modules/security-group"
  name        = "monitoring-sg"
  description = "Allow SSH, Grafana, Prometheus, Flask ports"
  vpc_id      = var.vpc_id
  allowed_ips = ["${local.my_ip}/32"]
}
# EC2 Instance Module
module "monitoring_ec2" {
  source          = "./modules/ec2-instance"
  ami             = data.aws_ami.amazon_linux_2.id
  instance_type   = "t2.micro"
  key_name        = "my-cicd-app-key"
  subnet_id       = var.subnet_id
  security_groups = [module.monitoring_sg.sg_id]
  user_data = templatefile("${path.module}/user_data.sh.tpl", {
    grafana_password = var.grafana_password
  })
  name = "web-server"
}


resource "random_id" "suffix" {
  byte_length = 4
}

