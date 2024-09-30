# Network domains
resource "aviatrix_segmentation_network_domain" "blue" {
  domain_name = "blue"
}

resource "aviatrix_segmentation_network_domain" "green" {
  domain_name = "green"
}

# Associations
resource "aviatrix_segmentation_network_domain_association" "blue" {
  transit_gateway_name = var.aws_transit_gw_name
  network_domain_name  = aviatrix_segmentation_network_domain.blue.domain_name
  attachment_name      = var.aws_spoke_gw_name
}

resource "aviatrix_segmentation_network_domain_association" "green" {
  transit_gateway_name = var.azure_transit_gw_name
  network_domain_name  = aviatrix_segmentation_network_domain.green.domain_name
  attachment_name      = var.azure_spoke_gw_name
}

# Connections policies
resource "aviatrix_segmentation_network_domain_connection_policy" "blue_green" {
  count         = var.apply_policy ? 1 : 0
  domain_name_1 = aviatrix_segmentation_network_domain.blue.domain_name
  domain_name_2 = aviatrix_segmentation_network_domain.green.domain_name
}
