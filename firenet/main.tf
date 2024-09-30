# Enable palo policies
resource "aviatrix_transit_firenet_policy" "peering" {
  transit_firenet_gateway_name = var.firenet_transit_gateway_name
  inspected_resource_name      = "PEERING:${var.firenet_transit_peer_gateway_name}"
  depends_on                   = [data.aviatrix_firenet_vendor_integration.palo]
}

resource "aviatrix_transit_firenet_policy" "spoke" {
  transit_firenet_gateway_name = var.firenet_transit_gateway_name
  inspected_resource_name      = "SPOKE:${var.firenet_spoke_gateway_name}"
  depends_on                   = [data.aviatrix_firenet_vendor_integration.palo]
}

# Enable palo vendor integration
data "aviatrix_firenet_vendor_integration" "palo" {
  vpc_id            = var.firewall_vpc_id
  instance_id       = var.firewall_instance_id
  vendor_type       = "Palo Alto Networks VM-Series"
  public_ip         = var.firewall_public_ip
  username          = var.firewall_username
  password          = var.firewall_password
  firewall_name     = var.firewall_name
  number_of_retries = 5
  save              = true
}
