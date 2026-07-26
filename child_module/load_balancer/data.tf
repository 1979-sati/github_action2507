data "azurerm_public_ip" "lb_pip" {
  for_each = {
    for k, v in var.load_balancers : k => v
    if lookup(v, "public_ip_name", null) != null
  }

  name                = each.value.public_ip_name
  resource_group_name = each.value.resource_group_name
}

data "azurerm_network_interface" "vm_nics" {
  for_each = {
    for pair in flatten([
      for lb_key, lb in var.load_balancers : [
        for nic in lookup(lb, "backend_nics", []) : {
          key                 = "${lb_key}_${nic.nic_name}"
          lb_key              = lb_key
          nic_name            = nic.nic_name
          resource_group_name = nic.resource_group_name
        }
      ]
    ]) : pair.key => pair
  }

  name                = each.value.nic_name
  resource_group_name = each.value.resource_group_name
}
