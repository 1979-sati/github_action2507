resource "azurerm_application_gateway" "appgw" {
  for_each = var.app_gateways

  name                = each.value.name
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  sku {
    name     = lookup(each.value, "sku_name", "Standard_v2")
    tier     = lookup(each.value, "sku_tier", "Standard_v2")
    capacity = lookup(each.value, "capacity", 2)
  }

  gateway_ip_configuration {
    name      = "${each.value.name}-ip-config"
    subnet_id = data.azurerm_subnet.appgw_subnet[each.key].id
  }

  frontend_port {
    name = "${each.value.name}-feport"
    port = lookup(each.value, "frontend_port", 80)
  }

  frontend_ip_configuration {
    name                 = "${each.value.name}-feip"
    public_ip_address_id = data.azurerm_public_ip.appgw_pip[each.key].id
  }

  backend_address_pool {
    name         = "${each.value.name}-beap"
    ip_addresses = lookup(each.value, "backend_ip_addresses", null)
    fqdns        = lookup(each.value, "backend_fqdns", null)
  }

  backend_http_settings {
    name                  = "${each.value.name}-http-set"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = lookup(each.value, "backend_port", 80)
    protocol              = lookup(each.value, "backend_protocol", "Http")
    request_timeout       = 60
  }

  http_listener {
    name                           = "${each.value.name}-httplstn"
    frontend_ip_configuration_name = "${each.value.name}-feip"
    frontend_port_name             = "${each.value.name}-feport"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${each.value.name}-rtrul"
    rule_type                  = "Basic"
    priority                   = lookup(each.value, "rule_priority", 1)
    http_listener_name         = "${each.value.name}-httplstn"
    backend_address_pool_name  = "${each.value.name}-beap"
    backend_http_settings_name = "${each.value.name}-http-set"
  }
}
