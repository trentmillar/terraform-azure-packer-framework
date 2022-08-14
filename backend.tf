terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "dev-op"

    workspaces {
      name = "terraform-azure-packer-framework"
    }
  }
}
