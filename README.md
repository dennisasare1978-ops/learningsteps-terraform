# 🔐 LearningSteps – Secure Azure Private Infrastructure (Terraform)

This project demonstrates the design and deployment of a secure Azure cloud architecture using Terraform, based on Zero Trust principles.

The solution ensures that all critical resources—including the virtual machine and PostgreSQL database—are fully private and inaccessible from the public internet.

---

## 🚀 Architecture Overview

The infrastructure includes:

* Azure Virtual Network (VNet)
* Subnet secured with Network Security Group (NSG)
* Linux Virtual Machine (private, no public IP)
* Azure Bastion for secure remote access
* PostgreSQL Flexible Server (private access only)
* Private Endpoint for database connectivity
* Private DNS Zone for internal name resolution

---

## 🔐 Security Design

This architecture enforces a **Zero Trust model**:

* ❌ No public IP exposure (enforced by Azure Policy)
* 🔐 Access only via Azure Bastion
* 🔒 Database accessible only through Private Endpoint
* 🌐 Internal DNS resolves DB to private IP (10.x.x.x)
* 🛡️ NSG restricts all unnecessary inbound traffic

---

## 🧪 Validation (Proof of Private Connectivity)

From inside the VM:

```bash
nslookup psql-learningsteps-3i7fue.postgres.database.azure.com
```

Result:

```
Address: 10.0.1.5
```

This confirms that database traffic is routed entirely through the private network.

---

## 📸 Screenshots

### 🔐 VM Access (Bastion)

![VM Access](screenshots/vm-identity.png)

### 🌐 Private Network IP

![Private IP](screenshots/private-ip.png)

### 🔥 Private DNS Resolution (Key Proof)

![DNS](screenshots/nslookup-private.png)

---

## 🛠️ Technologies

* Terraform (Infrastructure as Code)
* Microsoft Azure
* Azure CLI
* Linux (Ubuntu)

---

## 🧠 Key Learnings

* Designing secure cloud infrastructure using Terraform
* Implementing Zero Trust networking in Azure
* Configuring and troubleshooting Private Endpoints
* Resolving private DNS issues in cloud environments
* Working under Azure Policy constraints

---

## 📘 Project Background

This project evolved from an intentionally insecure baseline (public VM and database) into a fully secured architecture using private networking and Zero Trust principles.

---

## ⚠️ Security Notice

Sensitive files (Terraform state, credentials, SSH keys) are excluded from version control via `.gitignore`.

---

## 👤 Author

Kwabena

