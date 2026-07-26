module "resource_group" {
  source          = "../child_module/resource_group"
  resource_groups = var.resource_groups
}

module "virtual_network" {
  depends_on       = [module.resource_group]
  source           = "../child_module/virtual_network"
  virtual_networks = var.virtual_networks
}

module "resource_subnet" {
  depends_on = [module.virtual_network]
  source     = "../child_module/resource_subnet"
  subnets    = var.subnets
}

module "public_ip" {
  depends_on = [module.resource_group]
  source     = "../child_module/public_ip"
  public_ips = var.public_ips
}

module "virtual_machine" {
  depends_on = [
    module.resource_subnet,
    module.public_ip
  ]
  source = "../child_module/virtual_machine"
  vms    = var.vms
}

module "bastion" {
  depends_on = [
    module.resource_subnet,
    module.public_ip
  ]
  source   = "../child_module/bastion"
  bastions = var.bastions
}

module "load_balancer" {
  depends_on = [
    module.virtual_machine,
    module.public_ip
  ]
  source         = "../child_module/load_balancer"
  load_balancers = var.load_balancers
}

module "application_gateway" {
  depends_on = [
    module.resource_subnet,
    module.public_ip
  ]
  source       = "../child_module/application_gateway"
  app_gateways = var.app_gateways
}