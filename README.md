# 🔐 LearningSteps – Secure Azure Private Architecture

This project demonstrates a secure, production-style Azure deployment using Terraform, based on Zero Trust networking principles.

Unlike a basic deployment, this architecture ensures that both the virtual machine and PostgreSQL database are completely private and not exposed to the public internet.

---

## 🚀 Architecture Overview

* Azure Virtual Network (VNet)
* Subnet with Network Security Group (NSG)
* Linux Virtual Machine (no public IP)
* Azure Bastion for secure SSH access
* PostgreSQL Flexible Server (public access disabled)
* Private Endpoint for database connectivity
* Private DNS Zone for internal name resolution

---

## 🔐 Security Features

* No public IP on the virtual machine (enforced via Azure Policy)
* SSH access only through Azure Bastion
* PostgreSQL database is not publicly accessible
* Private Endpoint ensures database traffic stays inside the VNet
* DNS resolves database hostname to private IP (10.x.x.x)

---

## 🧪 Validation (Proof of Private Connectivity)

Inside the VM:

```bash
nslookup psql-learningsteps-3i7fue.postgres.database.azure.com
```

Result:

```
Address: 10.0.1.5
```

This confirms that all database communication is routed through the private network.

---

## 📸 Screenshots

### 🔐 VM Access (Bastion)

![VM](screenshots/vm-identity.png)

### 🌐 Private IP Address

![IP](screenshots/private-ip.png)

### 🔥 Private DNS Resolution

![DNS](screenshots/nslookup-private.png)

---

## 🛠️ Technologies Used

* Terraform
* Microsoft Azure
* Azure CLI
* Linux (Ubuntu)

---

## 🧠 Key Learnings

* Designing secure cloud infrastructure using Terraform
* Implementing Zero Trust architecture in Azure
* Configuring and troubleshooting Private Endpoints
* Working with Azure Policy restrictions (no public IP)
* Ensuring secure database connectivity via Private DNS

---

## ⚠️ Security Note

Sensitive files such as Terraform state, SSH keys, and credentials are excluded from this repository.

---

## 👤 Author

Kwabena
