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

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
}
resource "aws_instance" "monitoring_ec2" {
  ami                    = data.aws_ami.amazon_linux_2023.id
  instance_type          = "t2.micro"
  key_name               = "my-cicd-app-key"
  vpc_security_group_ids = [aws_security_group.monitoring_sg.id]

  user_data = file("user_data.sh")

  tags = {
    Name = "Monitoring-EC2"
  }
}

resource "aws_security_group" "monitoring_sg" {
  name        = "monitoring-sg"
  description = "Allow HTTP, HTTPS, and Grafana"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9100
    to_port     = 9100
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/32"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_bucket" "app_logs" {
  bucket = "my-flask-app-logs-${random_id.suffix.hex}"

  tags = {
    Name = "flask-app-logs"
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}

