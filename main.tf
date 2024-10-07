module "mcna" {
  count                      = var.deploy_mcna ? 1 : 0
  source                     = "./mcna"
  backbone                   = local.backbone
  apply_custom_spoke_routing = var.apply_custom_spoke_routing
}

module "firenet" {
  count                             = var.enable_firenet ? 1 : 0
  source                            = "./firenet"
  firenet_transit_gateway_name      = module.mcna[0].transit_aws.transit_gateway.gw_name
  firenet_transit_peer_gateway_name = module.mcna[0].transit_azure.transit_gateway.gw_name
  firenet_spoke_gateway_name        = module.mcna[0].spoke_gw_aws.spoke_gateway.gw_name
  firewall_vpc_id                   = module.mcna[0].firewall.vpc_id
  firewall_instance_id              = module.mcna[0].firewall.instance_id
  firewall_public_ip                = module.mcna[0].firewall.public_ip
  firewall_name                     = module.mcna[0].firewall.firewall_name
  firewall_username                 = local.firewall_username
  firewall_password                 = var.firewall_password
}

module "segmentation" {
  count                 = var.apply_segmentation ? 1 : 0
  source                = "./segmentation"
  azure_transit_gw_name = module.mcna[0].transit_azure.transit_gateway.gw_name
  aws_transit_gw_name   = module.mcna[0].transit_aws.transit_gateway.gw_name
  azure_spoke_gw_name   = module.mcna[0].spoke_gw_aws.spoke_gateway.gw_name
  aws_spoke_gw_name     = module.mcna[0].spoke_gw_azure.spoke_gateway.gw_name
  apply_policy          = var.apply_policy
}

module "dcf" {
  count                   = var.enable_dcf ? 1 : 0
  source                  = "./dcf"
  azure_spoke_vpc_id      = module.mcna[0].spoke_vpc_azure.vpc_id
  aws_spoke_vpc_id        = module.mcna[0].spoke_vpc_aws.vpc_id
  aws_region              = local.backbone.aws.transit_region_name
  azure_region            = local.backbone.azure.transit_region_name
  aws_account             = local.backbone.aws.transit_account
  azure_account           = local.backbone.azure.transit_account
  enable_sg_orchestration = var.enable_sg_orchestration
  enable_dcf_tag_rule     = var.enable_dcf_tag_rule
}
