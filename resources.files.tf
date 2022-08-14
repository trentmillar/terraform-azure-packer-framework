# Providers
# https://www.terraform.io/docs/configuration/terraform.html
# https://www.terraform.io/docs/configuration/providers.html
# https://www.terraform.io/docs/configuration/expressions.html
# https://www.terraform.io/docs/configuration/functions.html


# Variables
# https://www.terraform.io/docs/configuration/variables.html
# https://www.terraform.io/docs/configuration/types.html


# Data Sources
# https://www.terraform.io/docs/configuration/data-sources.html


# Modules and Resources
# https://www.terraform.io/docs/configuration/modules.html
# https://www.terraform.io/docs/configuration/resources.html

module "action_cidrs" {
  source           = "github.com/trentmillar/terraform-networking-github-cidrs"
  cidr_count_limit = 200 - length(local.other_cidrs)
  cidr_type        = "actions"
}

# Locals
# https://www.terraform.io/docs/configuration/locals.htmlå

locals {
  cidrs = [for k, v in module.action_cidrs.cidrs : k]
  other_cidrs = [for cidr in [
    # ADD YOUR IP(S) HERE
    ] : trimsuffix(cidr, "/32")
  ]
  files = {
    for file in fileset(format("%s/packages", path.module), "*") : file => 1 if length(regexall("^\\..+", file)) == 0
  }
  tags = {
    packages = true
  }
}

resource "azurerm_storage_account" "files" {
  name                     = format("storagegpackerfiles%s", var.environment)
  resource_group_name      = azurerm_resource_group.files.name
  location                 = azurerm_resource_group.files.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.tags

  # Used to block files from IPs except GitHub actions
  /* network_rules {
    default_action             = "Deny"
    ip_rules                   = concat(local.other_cidrs, local.cidrs)
    virtual_network_subnet_ids = []
  } */
}

resource "azurerm_storage_container" "files" {
  name                  = format("stgcontainer-packer-files-%s", var.environment)
  storage_account_name  = azurerm_storage_account.files.name
  container_access_type = "container"
}

# Upload files using VPN and the CLI
/* resource "azurerm_storage_blob" "files" {
  for_each               = local.files
  name                   = each.key
  storage_account_name   = azurerm_storage_account.files.name
  storage_container_name = azurerm_storage_container.files.name
  type                   = "Block"
  source                 = each.key
} */
