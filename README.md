# AWS Flask App with Docker, Terraform, and GitHub Actions

This project deploys a simple Flask application on an AWS EC2 instance using Docker and Terraform. CI/CD is managed via GitHub Actions.

Features

- Flask app containerized using Docker
- Infrastructure as Code using Terraform
- EC2 instance provisioning on AWS
- Security group configuration
- CI/CD deployment with GitHub Actions
- Auto-start Docker container on EC2 launch

 Tech Stack

- AWS (EC2, IAM, VPC, Security Groups)
- Terraform
- Docker
- Flask (Python)
- GitHub Actions (CI/CD)
- Amazon Linux 2023


STRUCTURE

My-CI-CD-Project/
├── .github/
│   └── workflows/
│       └── main.yml            ← GitHub Actions CI/CD workflow
├── terraform/
│   ├── main.tf                 ← AWS resources (EC2, SG, etc.)
│   ├── variables.tf            ← Terraform input variables
│   ├── outputs.tf              ← Terraform outputs
│   └── provider.tf             ← Terraform AWS provider config
├── app/
│   └── app.py                  ← Your Flask web app
├── Dockerfile                  ← Dockerfile for Flask app
├── README.md                   ← Main project documentation
