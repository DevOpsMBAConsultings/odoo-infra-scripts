# MBA – Odoo Infrastructure (Nginx Reverse Proxy)

This repository contains a **standardized, repeatable installation process**
to configure **Nginx as a reverse proxy** for **Odoo Community** on **Ubuntu**,
exposing Odoo on **port 80**.

This is part of the **same product line** as the Odoo Community install process,
following the **exact same structure and execution model**.

---

## 🎯 Objective

- Configure Nginx as a reverse proxy for Odoo
- Expose Odoo on **port 80**
- Keep Odoo internal on **port 8069**
- Apply a **single standard process** for 90% of customers
- Reduce setup time from hours to minutes
- Eliminate manual configuration and drift
- Make infrastructure changes **repeatable and auditable**

---

## 🧱 What this repo provides

- A **single standard install command** (`install.sh`)
- Environment-based configuration (no hardcoded values)
- Automated setup for:
  - Nginx reverse proxy
  - Firewall rules (UFW)
- A structure designed for **DevOps reuse**
- A foundation for future infrastructure modules:
  - SSL / Let’s Encrypt
  - Domains
  - Backups
  - Monitoring
  - Electronic invoicing (PAC)

---

## 🚀 Target audience

- MBA Consultings internal team
- DevOps / ERP implementations
- Small & medium businesses using **Odoo Community**

---

## ⚠️ Important

This repository **does NOT store passwords, secrets, or certificates**.  
All sensitive values are defined **locally on each server**.

---

Maintained by **MBA Consultings**  
https://mbaconsultings.com

---

## ✅ Standard Install – Nginx for Odoo (Port 80)

Run the following commands on an **Ubuntu server where Odoo is already running
on port 8069**.

This process:
- Installs Nginx
- Configures reverse proxy
- Opens port 80
- Keeps port 8069 internal
- Requires **no manual configuration**

```bash
sudo apt update -y && sudo apt install -y git
git clone https://github.com/DevOpsMBAConsultings/odoo-infra-scripts.git
cd odoo-infra-scripts
chmod +x install.sh install/*.sh nginx/scripts/*.sh nginx/run.sh
sudo ./install.sh