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

## 🔐 AWS Credentials Setup
Terraform requires AWS credentials to provision resources.
### Option 1: AWS CLI (Recommended)
```sh
aws configure
```
Provide:
AWS Access Key ID


AWS Secret Access Key


Default region (e.g. ap-south-1)


Output format (optional)



### Option 2: Environment Variables
```sh
export AWS_ACCESS_KEY_ID=xxxx
export AWS_SECRET_ACCESS_KEY=xxxx
export AWS_DEFAULT_REGION=ap-south-1
```

### Required IAM Permissions

The IAM identity used must have permissions for:

- **VPC & Networking**
- **EC2 & Auto Scaling**
- **Application Load Balancer**
- **RDS**
- **IAM**
- **CloudWatch**
- **Route53**


###  📁 Project Structure
```sh
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
```

✔ Modular structure
 ✔ Clear separation of responsibilities
 ✔ Infrastructure defined entirely via IaC

## ⚙️ Configuration Notes (Very Important)

This project uses a mixed configuration approach:

### 🔒 Predefined (Hard-coded for PoC clarity)

These values are already set inside Terraform modules:

- **VPC CIDR and subnet CIDRs**
- **Database name**
- **Route53 hosted zone reference**
- **Internal ALB configuration**
- **Private subnet placement**

👉 **This ensures:**

- Consistent architecture  
- Easier evaluation  
- No ambiguity during review  

### 🛠️ If You Want to Customize

If you want to change:

- CIDR ranges  
- Route53 zone  
- Database credentials  
- On-prem CIDR (for VPN routing)  

You must update:

- `variables.tf`  
- `terraform.tfvars` (if used)  
- Corresponding module files

## 🚀 Deploying the Infrastructure
### Step 1: Clone the Repository
```sh
git clone <your-repository-url>
cd hybrid-cloud-infrastructure-aws/terraform
```

### Step 2: Initialize Terraform
Initializes providers and prepares the working directory.
```sh
terraform init
```

### Step 3: Review the Execution Plan
Always review planned changes before applying.
```sh
terraform plan
```
The execution plan includes:

- **VPC & subnets**  
- **Internal Application Load Balancer (ALB)**  
- **Auto Scaling Group (ASG)**  
- **RDS MySQL (Multi-AZ)**  
- **IAM roles & policies**  
- **Security groups & routing**  
- **CloudWatch alarms**


### Step 4: Apply the Configuration
```sh
terraform apply
```
Type `yes` when prompted.
### ⚙️ What Terraform Will Do

Terraform will:

- **Create networking first**  
- **Attach routing and gateways**  
- **Launch EC2 instances via Auto Scaling Group (ASG)**  
- **Provision RDS in private subnets**  
- **Configure monitoring and scaling**

⏳ **Deployment may take 10–15 minutes**, mainly due to RDS creation.

⏳ Expected deployment time: ~10–15 minutes
 (RDS provisioning takes the longest)

## ✅ Post-Deployment Validation
After successful deployment, verify:

- ✔ **ALB target group shows healthy instances**  
- ✔ **EC2 instances are running in private subnets**  
- ✔ **RDS is private and Multi-AZ**  
- ✔ **Auto Scaling policies are attached**  
- ✔ **CloudWatch alarms are created**
(Optional)
```sh
terraform output
```

## 🧹 Teardown (Clean Resource Removal)
To destroy all AWS resources created by this project:
```sh
terraform destroy
```
Type `yes` when prompted.

Terraform will safely:

- **Detach dependencies**  
- **Remove ALB, ASG, and EC2 instances**  
- **Delete RDS** (final snapshot enabled)  
- **Clean up VPC and networking**


