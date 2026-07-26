resource_groups = {
  rg = {
    name     = "rg_dev"
    location = "centralindia"
  }
   rg1 = {
    name     = "rg_dev1"
    location = "centralindia"
  }
}

virtual_networks = {
  vnet = {
    name                = "vnet_dev"
    location            = "centralindia"
    resource_group_name = "rg_dev"
    address_space       = ["10.0.0.0/16"]
  }
}

subnets = {
  snet = {
    name                 = "subnet_dev"
    resource_group_name  = "rg_dev"
    virtual_network_name = "vnet_dev"
    address_prefixes     = ["10.0.1.0/24"]
  }
  snet1 = {
    name                 = "subnet1_dev"
    resource_group_name  = "rg_dev"
    virtual_network_name = "vnet_dev"
    address_prefixes     = ["10.0.2.0/24"]
  }
  bastion_snet = {
    name                 = "AzureBastionSubnet"
    resource_group_name  = "rg_dev"
    virtual_network_name = "vnet_dev"
    address_prefixes     = ["10.0.3.0/26"]
  }
  appgw_snet = {
    name                 = "appgw_subnet"
    resource_group_name  = "rg_dev"
    virtual_network_name = "vnet_dev"
    address_prefixes     = ["10.0.4.0/24"]
  }
}

public_ips = {
  vm1 = {
    name                = "pip-vm1"
    location            = "centralindia"
    resource_group_name = "rg_dev"
  }
  vm2 = {
    name                = "pip-vm2"
    location            = "centralindia"
    resource_group_name = "rg_dev"
  }
  bastion = {
    name                = "pip-bastion"
    location            = "centralindia"
    resource_group_name = "rg_dev"
  }
  lb = {
    name                = "pip-lb"
    location            = "centralindia"
    resource_group_name = "rg_dev"
  }
  appgw = {
    name                = "pip-appgw"
    location            = "centralindia"
    resource_group_name = "rg_dev"
  }
}

vms = {
  vm1 = {
    vm_name              = "vm1"
    nic_name             = "nic1"
    public_ip_name       = "pip-vm1"
    subnet_name          = "subnet_dev"
    virtual_network_name = "vnet_dev"
    resource_group_name  = "rg_dev"
    location             = "centralindia"
    vm_size              = "Standard_D2as_v5"
    admin_username       = "azureuser"
    admin_password       = "User@12345"
  }
  vm2 = {
    vm_name              = "vm2"
    nic_name             = "nic2"
    public_ip_name       = "pip-vm2"
    subnet_name          = "subnet1_dev"
    virtual_network_name = "vnet_dev"
    resource_group_name  = "rg_dev"
    location             = "centralindia"
    vm_size              = "Standard_D2as_v5"
    admin_username       = "azureuser"
    admin_password       = "User@12345"
  }
}

bastions = {
  bastion1 = {
    name                 = "bastion-dev"
    location             = "centralindia"
    resource_group_name  = "rg_dev"
    virtual_network_name = "vnet_dev"
    subnet_name          = "AzureBastionSubnet"
    public_ip_name       = "pip-bastion"
    sku                  = "Standard"
  }
}

load_balancers = {
  lb1 = {
    name                = "lb-dev"
    location            = "centralindia"
    resource_group_name = "rg_dev"
    public_ip_name      = "pip-lb"
    frontend_ip_name    = "PublicIPAddress"
    backend_pool_name   = "BackEndAddressPool"
    probe_name          = "http-probe"
    probe_port          = 80
    probe_protocol      = "Http"
    probe_request_path  = "/"
    rule_name           = "LBRule"
    rule_protocol       = "Tcp"
    frontend_port       = 80
    backend_port        = 80
    backend_nics = [
      {
        nic_name            = "nic1"
        resource_group_name = "rg_dev"
      },
      {
        nic_name            = "nic2"
        resource_group_name = "rg_dev"
      }
    ]
  }
}

app_gateways = {
  appgw1 = {
    name                 = "appgw-dev"
    location             = "centralindia"
    resource_group_name  = "rg_dev"
    virtual_network_name = "vnet_dev"
    subnet_name          = "appgw_subnet"
    public_ip_name       = "pip-appgw"
    sku_name             = "Standard_v2"
    sku_tier             = "Standard_v2"
    capacity             = 2
    frontend_port        = 80
    backend_port         = 80
    backend_protocol     = "Http"
    backend_ip_addresses = ["10.0.1.4", "10.0.2.4"]
  }
}
