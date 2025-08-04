**Project Architecture Overview**
This document provides a overview of the project's infrastructure, deployment, and continuous integration/continuous deployment (CI/CD) workflow. The architecture is designed to be fully automated and cloud-native, utilizing GitHub Actions for CI/CD and AWS services provisioned by Terraform.

**Features**

- Flask app containerized using Docker
- Infrastructure as Code using Terraform
- EC2 instance provisioning on AWS
- Security group configuration
- CI/CD deployment with GitHub Actions
- Auto-start Docker container on EC2 launch

 **Tech Stack**

- AWS (EC2, IAM, VPC, Security Groups)
- Terraform
- Docker
- Flask (Python)
- GitHub Actions (CI/CD)
- Amazon Linux 2023

**Architecture Diagram**

<img width="1391" height="900" alt="Automated-CI-CD-FLASK" src="https://github.com/user-attachments/assets/549d5e70-a648-4de8-95f8-177ec3002db9" />

**Architecture**
The system is composed of the following key components:
- **Source Code:** Stored in a GitHub repository.
- **CI/CD Pipeline:** Triggered by GitHub Actions to build a Docker image.
- **Infrastructur**e: Deployed on AWS using Terraform.
- **Application Hosting:** A single EC2 instance running the Flask application inside a Docker container.
- **Logging:** Centralized in AWS CloudWatch.


**Detailed Workflow**

1. **Source Control & CI/CD Pipeline:**
The process begins when a developer pushes new code to the main branch of the GitHub repository.
    - **Code Push:** A developer commits and pushes code to the designated GitHub repository.
    - **GitHub Actions Trigger:** This action triggers a GitHub Actions workflow.
    - **Build & Push:** The workflow automatically builds a Docker image from the application's source code. Optionally, this image is then pushed to a container registry like Docker Hub.

2. **Infrastructure Provisioning with Terraform**:
The AWS infrastructure required to run the application is defined and managed using Terraform.
    - EC2 Instance: Terraform provisions an Amazon EC2 instance using an Amazon Linux AMI, which will host the application. 
    - Security Group: A Security Group is created to control network traffic, allowing essential access for HTTP (port 80) and SSH (port 22).
    - S3 Bucket: An S3 bucket is created specifically for storing logs and other artifacts.
    CloudWatch Log Group: A CloudWatch Log Group is established to aggregate and monitor application logs.

3.  **Application Deployment**:
The deployment process is fully automated using EC2 User Data, a script that runs the first time the instance is booted.

    - User Data Execution: The EC2 instance, upon launch, executes a user data script.
    - Install Docker: The script first installs the Docker runtime environment on the EC2 instance.
    - Pull & Run: It then pulls the latest Docker image from the container registry and starts the Flask application within a container, exposing it on port 80.
  
4. **Monitoring & Logging**:
To ensure the application's health and provide insight into its operations, all application logs are centralized.
    - Log Forwarding: The Flask application is configured to send its output (stdout/stderr) directly to CloudWatch.
    - Centralized Monitoring: These logs are collected in the designated CloudWatch Log Group, allowing for easy monitoring, searching, and alerting.
    - Persistent Storage: Logs are retained in CloudWatch and can be archived in the dedicated S3 bucket for long-term storage and analysis.


