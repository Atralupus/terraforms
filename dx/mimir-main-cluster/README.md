## About This Project

This repository includes configurations actively used in production to manage the infrastructure for **Mimir**, the service powering [Mimir GraphQL](https://mimir.nine-chronicles.dev/odin/graphql/). These configurations are designed to meet the specific needs of this service and are continuously maintained.

## Prerequisites

- **Terraform**: Installed on your local machine.
- **1Password Access**: Access to our 1Password vault containing the necessary secrets.
- **`op` Command-Line Tool**: Installed for injecting secrets from 1Password into your Terraform configurations.


## Setup Instructions

### 1. Prepare Your Terraform Configuration

Make sure your Terraform configuration files are correctly set up. We use a template file named `terraform.private.auto.tfvars.tpl` to manage secrets. This file contains placeholders for secrets that will be injected from 1Password.

**Example `terraform.private.auto.tfvars.tpl` content**:

```hcl
...
existing_subnet_ids_public = "op://DX/DX Ecs Cluster tfvars/add more/existing_subnet_ids_public"
...
```

### 2. Inject Secrets with 1Password

Before running any Terraform commands, inject secrets into your configuration using the `op` command-line tool. This replaces placeholders in `terraform.private.auto.tfvars.tpl` with actual secrets from 1Password and outputs the result to `terraform.private.auto.tfvars`.

**Command**:

```bash
op inject -i terraform.private.auto.tfvars.tpl -o terraform.private.auto.tfvars
```

### 3. Proceed with Terraform Commands

Once secrets are injected, you can manage your infrastructure with Terraform. 

#### Important Note for `terraform apply`
When running `terraform apply`, **always use the `-parallelism=1` option** to avoid concurrency issues. For example:

```bash
terraform apply -parallelism=1
```

#### Combining Commands
For convenience, you can combine the secrets injection and Terraform planning into one command:

```bash
op inject -i terraform.private.auto.tfvars.tpl -o terraform.private.auto.tfvars && terraform plan
```
