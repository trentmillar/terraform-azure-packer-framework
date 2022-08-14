resource "azurerm_resource_group" "shared" {
  name     = format("rg-images-shared-%s", var.environment)
  location = var.location
}

resource "azurerm_resource_group" "files" {
  name     = format("rg-files-shared-%s", var.environment)
  location = var.location
}
