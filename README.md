# 🧱 Terraform AWS Modules – EC2 | S3 | VPC | EKS

This repository contains production-ready **Terraform modules** for provisioning core AWS infrastructure components with reusable, modular code.

> 🎯 Built for cloud practitioners, DevOps engineers, and students building real-world IaC solutions.

---

## 📦 Included Modules

| Module | Description |
|--------|-------------|
| `vpc`  | Create a custom VPC with public/private subnets, NAT Gateway, route tables |
| `s3`   | Secure S3 bucket with versioning, encryption, access policies |
| `ec2`  | Launch EC2 instances with key pairs, security groups, and user data |
| `eks`  | Setup an EKS cluster with worker node groups and IAM roles |

---

## 🚀 Quick Usage

Each module lives in its own folder and can be used independently:

```hcl
module "vpc" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
  ...
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = "my-terraform-bucket"
}
```
Initialize and apply:

terraform init & terraform apply

🎥 Learn with Hands-On Tutorials
Each module is explained with full walkthroughs on YouTube:

🔗 📺 Bishtify - Build Skills, Not Just Resumes
Subscribe for real-world AWS + DevOps content with hands-on examples.

🛠️ Premium repository includes:

3-tier-infra-app,

ECS with ALB,

RDS with Secrets,

S3 and DynamoDB Locking

and more..

📩 Request access (paid):
📧 support@bishtify.com

🤝 Connect With Me
📧 support@bishtify.com OR https://topmate.io/pradeep_singh_bisht
🔗 Get Bishtified with:
Bishtify - Let’s build skills — not just resumes! 🚀
