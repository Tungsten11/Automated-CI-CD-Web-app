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

variable "dockerhub_username" {
  description = "DockerHub username"
  type        = string
  sensitive   = true
}

resource "aws_instance" "web" {
  ami           = "ami-07833df4a1317c7a8" # Amazon Linux 2023
  instance_type = "t2.micro"
  key_name      = "my-cicd-app-key"

  user_data = <<-EOF
            #!/bin/bash
            dnf update -y
            dnf install -y docker
            systemctl start docker
            systemctl enable docker
            usermod -aG docker ec2-user

            docker run -d -p 80:80 seeker1/flaskapp:latest
    EOF


  tags = {
    Name = "flask-EC2-app"
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

resource "aws_cloudwatch_log_group" "flask_logs" {
  name              = "/aws/ec2/flaskapp"
  retention_in_days = 7
}
