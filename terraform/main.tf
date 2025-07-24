provider "aws" {
    region = "ap-southeast-1"
}

resource "aws_instance" "web" {
  ami       = "ami-07833df4a1317c7a8" # Amazon Linux 2023
  instance_type = "t2.micro"
  key_name = "my-cicd-app-key"

  user_data = <<-EOF
            #!/bin/bash
            amazon-linux-extras install docker -y
            systemctl start docker
            systemctl enable docker
            usedmod -aG docker ec2-user

            #Pull image and run
            docker run -d -p 80:80 seeker1/flask:latest
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
  name = "/aws/ec2/flaskapp"
  retention_in_days = 7
}