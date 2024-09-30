# https://registry.terraform.io/modules/terraform-aviatrix-modules
# https://registry.terraform.io/modules/terraform-aviatrix-modules/backbone/aviatrix/latest
module "backbone" {
  source  = "terraform-aviatrix-modules/backbone/aviatrix"
  version = "v1.2.2"
  global_settings = {
    transit_ha_gw = false
  }

  transit_firenet = var.backbone
}

data "aviatrix_vpc" "spoke_aws" {
  name = "aws-spoke"
}

data "aviatrix_vpc" "spoke_azure" {
  name = "azure-spoke"
}

# https://registry.terraform.io/modules/terraform-aviatrix-modules/mc-spoke/aviatrix/latest
module "spoke_aws" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.6.3"

  cloud                            = "aws"
  name                             = "aws-spoke"
  use_existing_vpc                 = true
  vpc_id                           = data.aviatrix_vpc.spoke_aws.vpc_id
  gw_subnet                        = data.aviatrix_vpc.spoke_aws.public_subnets[0].cidr
  region                           = var.backbone.aws.transit_region_name
  account                          = var.backbone.aws.transit_account
  instance_size                    = "t3.medium"
  transit_gw                       = module.backbone.transit["aws"].transit_gateway.gw_name
  included_advertised_spoke_routes = var.apply_custom_spoke_routing ? "172.16.0.1/32, 10.1.2.0/24" : null
  ha_gw                            = false
  attached                         = true
}

module "spoke_azure" {
  source  = "terraform-aviatrix-modules/mc-spoke/aviatrix"
  version = "1.6.3"

  cloud            = "azure"
  name             = "azure-spoke"
  use_existing_vpc = true
  vpc_id           = data.aviatrix_vpc.spoke_azure.vpc_id
  gw_subnet        = data.aviatrix_vpc.spoke_azure.public_subnets[0].cidr
  az_support       = false
  region           = var.backbone.azure.transit_region_name
  account          = var.backbone.azure.transit_account
  instance_size    = "Standard_B2ms"
  transit_gw       = module.backbone.transit["azure"].transit_gateway.gw_name
  ha_gw            = false
  attached         = true
}

