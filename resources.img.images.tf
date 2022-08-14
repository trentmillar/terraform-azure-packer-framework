locals {
  shared_images = {
    "CentOS_7-5" = {
      type      = "Linux"
      publisher = "AcmeDevOps"
      offer     = "CentOS"
      sku       = "7.5"
    }
    "WindowsServer_2019" = {
      type      = "Windows"
      publisher = "AcmeDevOps"
      offer     = "WindowsServer"
      sku       = "2019-Datacenter"
    }
  }
}

resource "azurerm_shared_image" "default" {
  for_each            = local.shared_images
  name                = each.key
  gallery_name        = azurerm_shared_image_gallery.default[each.value.type].name
  resource_group_name = azurerm_shared_image_gallery.default[each.value.type].resource_group_name
  location            = azurerm_shared_image_gallery.default[each.value.type].location
  os_type             = each.value.type

  identifier {
    publisher = each.value.publisher
    offer     = each.value.offer
    sku       = each.value.sku
  }
}
