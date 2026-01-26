## 🚀 Deployment Guide – Hybrid Cloud Infrastructure (Terraform)

This section describes how to deploy the AWS infrastructure defined in this repository using **Terraform**.

---

### ⚠️ Important Notes (Read First)

This project is designed as a **proof-of-concept hybrid architecture**.

To keep the setup **deterministic, review-friendly, and aligned with the assignment scope**, some values are intentionally **predefined inside the Terraform code**, such as:

- VPC and subnet CIDR ranges  
- Route53 hosted zone reference  
- Database name  
- Internal Application Load Balancer configuration  

👉 **No changes are required to deploy this project for evaluation purposes.**

---

## 🧰 Prerequisites

Before starting, ensure the following tools are installed and configured:

- An active **AWS account**
- **Terraform v1.x**
- **AWS CLI**
- **Git**

🔐 AWS Credentials Setup
Terraform requires AWS credentials to provision resources.
Option 1: AWS CLI (Recommended)
aws configure

Provide:
AWS Access Key ID


AWS Secret Access Key


Default region (e.g. ap-south-1)


Output format (optional)



Option 2: Environment Variables
export AWS_ACCESS_KEY_ID=xxxx
export AWS_SECRET_ACCESS_KEY=xxxx
export AWS_DEFAULT_REGION=ap-south-1


Required IAM Permissions
The IAM identity must allow access to:
VPC & Networking


EC2 & Auto Scaling


Application Load Balancer


RDS


IAM


CloudWatch


Route53



📁 Project Structure
Relevant Terraform layout:
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── modules/
│   ├── vpc/
│   ├── alb/
│   ├── asg/
│   ├── rds/
│   ├── iam/
│   ├── security-group/
│   └── route53/

✔ Modular structure
 ✔ Clear separation of responsibilities
 ✔ Infrastructure defined entirely via IaC

⚙️ Configuration Model
This project follows a mixed configuration strategy.
🔒 Predefined (Hard-coded for PoC Clarity)
The following values are intentionally fixed inside Terraform modules:
VPC and subnet CIDRs


Route53 hosted zone


Database name


Internal ALB configuration


Private subnet placement


Why this approach?
Removes ambiguity during evaluation


Ensures architectural consistency


Avoids misconfiguration during review



🛠️ Customization (Optional)
If customization is required (not needed for assignment):
You must update:
variables.tf


terraform.tfvars (if used)


Corresponding module definitions


Customizable areas include:
CIDR ranges


Route53 zone


Database credentials


On-prem CIDR for VPN routing


📌 For assessment submission, no customization is required.

🚀 Deploying the Infrastructure
Step 1: Clone the Repository
git clone <your-repository-url>
cd hybrid-cloud-infrastructure-aws/terraform


Step 2: Initialize Terraform
Initializes providers and prepares the working directory.
terraform init


Step 3: Review the Execution Plan
Always review planned changes before applying.
terraform plan

The plan includes:
VPC & subnets


Internal Application Load Balancer


Auto Scaling Group


RDS MySQL (Multi-AZ)


IAM roles & policies


Security groups & routing


CloudWatch alarms



Step 4: Apply the Configuration
terraform apply

Type yes when prompted.
Terraform will:
Create networking components


Configure routing and gateways


Launch EC2 instances via ASG


Provision RDS in private subnets


Configure monitoring and scaling policies


⏳ Expected deployment time: ~10–15 minutes
 (RDS provisioning takes the longest)

✅ Post-Deployment Validation
After successful deployment, verify:
✔ ALB target group shows healthy instances


✔ EC2 instances are running in private subnets


✔ RDS is private and Multi-AZ


✔ Auto Scaling policies are attached


✔ CloudWatch alarms are created


(Optional)
terraform output


🧹 Teardown (Clean Resource Removal)
To destroy all AWS resources created by this project:
terraform destroy

Type yes when prompted.
Terraform will safely:
Detach resource dependencies


Remove ALB, ASG, and EC2 instances


Delete RDS (final snapshot enabled)


Clean up VPC and networking components


✔ No orphaned resources
 ✔ Safe teardown using IaC


