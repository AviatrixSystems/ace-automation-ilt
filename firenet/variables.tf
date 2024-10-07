variable "firenet_transit_gateway_name" {
  description = "Aviatrix FireNet transit gateway name"
  type        = string
}

variable "firenet_transit_peer_gateway_name" {
  description = "Aviatrix FireNet policy peer transit gateway name"
  type        = string
}

variable "firenet_spoke_gateway_name" {
  description = "Aviatrix FireNet policy spoke gateway name"
  type        = string
}

variable "firewall_vpc_id" {
  description = "Aviatrix FireNet vpc id"
  type        = string
}

variable "firewall_instance_id" {
  description = "Aviatrix FireNet firewall instance id"
  type        = string
}

variable "firewall_public_ip" {
  description = "Aviatrix FireNet firewall public ip"
  type        = string
}

variable "firewall_name" {
  description = "Aviatrix FireNet firewall name"
  type        = string
}

variable "firewall_username" {
  description = "Aviatrix FireNet firewall username"
  type        = string
}

variable "firewall_password" {
  description = "Aviatrix FireNet firewall password"
  type        = string
}
