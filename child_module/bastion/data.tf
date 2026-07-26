data "azurerm_subnet" "bastion_subnet" {
  for_each = var.bastions

  name                 = each.value.subnet_name
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}

data "azurerm_public_ip" "bastion_pip" {
  for_each = var.bastions

  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}
