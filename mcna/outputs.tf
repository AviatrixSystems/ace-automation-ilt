output "transit_aws" {
  value = module.backbone.transit["aws"]
}
output "transit_azure" {
  value = module.backbone.transit["azure"]
}
output "spoke_gw_aws" {
  value = module.spoke_aws
}
output "spoke_gw_azure" {
  value = module.spoke_azure
}
output "firewall" {
  value = var.backbone.aws.firenet ? module.backbone.firenet["aws"].aviatrix_firewall_instance[0] : null
}
output "spoke_vpc_aws" {
  value = data.aviatrix_vpc.spoke_aws
}
output "spoke_vpc_azure" {
  value = data.aviatrix_vpc.spoke_azure
}
