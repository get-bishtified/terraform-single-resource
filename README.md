# 🧱 Terraform AWS Modules – EC2 | S3 | VPC | EKS | Grafana

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
| `grafana`| Provision and configure a Grafana instance on AWS (via EC2 or managed service) integrated with CloudWatch & Prometheus |

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

--
## 🎥 Learn With YouTube Tutorials

Each project is **explained step-by-step** on YouTube with visuals and walkthroughs:

🔗 [📺 Bishtify - Build Skills, Not Just Resumes](https://www.youtube.com/@getbishtified) 
🧠 Subscribe for weekly ML + CloudOps demos.

---

📩 **Contact:**  
📧 `support@bishtify.com`

🤝 Connect With Me - 📧 [Click here](https://topmate.io/pradeep_singh_bisht)
🔗 Get Bishtified with:
Bishtify - Let’s build skills — not just resumes! 🚀