# Terraform-project-1-terraform-github-auction-Aws
# AWS Modular Infrastructure with Terraform & GitHub Actions

![Build Status](https://img.shields.io/github/actions/workflow/status/michael-git-repo/Terraform-project-1-terraform-github-auction-Aws/terraform.yml?branch=main&label=CI%2FCD%20Pipeline)

Automated provisioning of core AWS networking (VPC, Subnet, Internet Gateway, Route Table) and compute resources (EC2 Instance, Security Group) using custom Terraform modules and GitHub Actions.

---

## 🏗️ Architecture Overview

```text
               +---------------------------------------------------------------------------------+
               | AWS Cloud                                                                       |
               | Region: us-east-1                                                               |
               |                                                                                 |
               |  +---------------------------------------------------------------------------+  |
               |  | Virtual Private Cloud (VPC)                                               |  |
               |  | Name: my-vpc (10.0.0.0/16)                                                |  |
               |  |                                                                           |  |
               |  |   +-------------------------------------------------------------------+   |  |
               |  |   | Availability Zone: us-east-1a                                     |   |  |
               |  |   |                                                                   |   |  |
               |  |   |   +-----------------------------------------------------------+   |   |  |
               |  |   |   | Public Subnet                                             |   |   |  |
               |  |   |   | Name: my-subnet (10.0.1.0/24)                            |   |   |  |
               |  |   |   |                                                           |   |   |  |
               |  |   |   |   +---------------------------------------------------+   |   |   |  |
               |  |   |   |   | Security Group: my-web-sg                         |   |   |   |  |
               |  |   |   |   | Rules: Inbound SSH (22) & HTTP (80)               |   |   |   |  |
               |  |   |   |   |                                                   |   |   |   |  |
Traffic -----> | [Internet] ->|   +-------------------------------------------+   |   |   |   |  |
 (Port 22/80)  |  Gateway |   |   | Amazon EC2 Instance                       |   |   |   |   |  |
               | my-gate-way  |   | Name: my-ec2-instance (t3.micro)          |   |   |   |   |  |
               |              |   +-------------------------------------------+   |   |   |   |  |
               |  |   |   |   +---------------------------------------------------+   |   |   |  |
               |  |   |   +-----------------------------------------------------------+   |   |  |
               |  |   +-------------------------------------------------------------------+   |  |
               |  +---------------------------------------------------------------------------+  |
               +---------------------------------------------------------------------------------+

            .
├── .github/
│   └── workflows/
│       └── terraform.yml          # GitHub Actions CI/CD workflow
├── modules/
│   ├── vpc/                       # VPC & Networking module
│   │   ├── main.tf                # VPC, Subnet, IGW, & Route Table definitions
│   │   ├── outputs.tf             # Exposes vpc_id and subnet_id
│   │   └── variables.tf           # Network CIDR inputs
│   └── ec2/                       # Compute module
│       ├── main.tf                # EC2 instance & Security Group definitions
│       ├── outputs.tf             # Exposes public IP
│       └── variables.tf           # Instance type & subnet inputs
├── main.tf                        # Root module calling VPC & EC2 modules
├── outputs.tf                     # Master outputs (EC2 Public IP)
├── provider.tf                    # AWS Provider configuration
├── variables.tf                   # Root variables (Region & Instance Type)
└── README.md                      # Project documentation   \

🛠️ Infrastructure ComponentsResource NameTypeDescriptionmy-vpcaws_vpcCIDR 10.0.0.0/16 with DNS hostnames enabledmy-subnetaws_subnetCIDR 10.0.1.0/24 in us-east-1a with auto-public IPmy-gate-wayaws_internet_gatewayEnables internet connectivity for the public subnetmy-public-rtaws_route_tableDirects 0.0.0.0/0 traffic to my-gate-waymy-web-sgaws_security_groupAllows inbound TCP traffic on ports 22 (SSH) and 80 (HTTP)my-ec2-instanceaws_instancet3.micro instance running Amazon Linux🔑 GitHub Actions SetupTo enable automated deployment, add the following secrets in your GitHub repository (Settings $\rightarrow$ Secrets and variables $\rightarrow$ Actions):Secret NameDescriptionAWS_ACCESS_KEY_IDAWS IAM User Access Key IDAWS_SECRET_ACCESS_KEYAWS IAM User Secret Access Key⚡ Deployment PipelineThe pipeline triggers automatically on GitHub pushes and pull requests:Format Check: Runs terraform fmt -check -recursive to enforce code standards.Initialization: Runs terraform init to load modules and the AWS provider.Plan: Runs terraform plan to preview infrastructure modifications.Apply: Automatically runs terraform apply -auto-approve when code is merged into the main branch.