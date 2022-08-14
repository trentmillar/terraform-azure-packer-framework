# terraform-azure-packer-framework
GitHub actions, Azure infrastructure, and packer library

# What is this?

This project does three things,
- Terraform project creates the Shared Image Gallery in your Azure subscription to store images build by Packer
- GitHub actions to validate and build Packer templates into Azure images. Images are built whenever a commit or pull merges into the main branch, may be a bit of overkill so you can remove these if you want
- Packer templates built during the GitHub action workflow.

# How to run - Terraform

1) Go to app.terraform.io and create a Terraform Cloud (TFC) free account. Then create a new Workspace we will use to run this project.

2) Open `backend.tf` and change the `organization` and `workspace name` to a workspace you created in TFC.

3) Create a new Service Principal in Azure. This will be used to run your Terraform project in TFC. Follow the steps in one of these docs:
- https://docs.microsoft.com/en-us/azure/developer/terraform/authenticate-to-azure?tabs=bash#create-a-service-principal
- https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/guides/service_principal_client_secret

4) Capture the `client_id`, `client_secret`, `tenant_id`, and `subscription_id` from the prior steps. Go to the TFC workspace and in the Variables tab, add these variables with the correct values. You will also need one more variable.

5) Make sure the TFC Workspace is mapped to this repo. Just follow the steps at Variables > Version Control

(optional), if you just want to deploy quickly you can delete `backend.tf` and run your `terraform init` & `terraform apply` locally. Just make sure you set or pass the values of the variables defined in `variables.tf`

