variable "backbone" {
  description = "Aviatrix transit backbone configuration details"
  type = map(object({
    transit_cloud                                = string,
    transit_cidr                                 = string,
    transit_region_name                          = string,
    transit_asn                                  = number,
    transit_account                              = string,
    transit_name                                 = string,
    transit_az_support                           = optional(bool),
    firenet                                      = optional(bool),
    firenet_bootstrap_bucket_name_1              = optional(string),
    firenet_firewall_image                       = optional(string),
    firenet_iam_role_1                           = optional(string),
    firenet_inspection_enabled                   = optional(bool),
    firenet_keep_alive_via_lan_interface_enabled = optional(bool),
  }))
}

variable "apply_custom_spoke_routing" {
  description = "Set to true to apply custom routing to spoke networks"
  type        = bool
  default     = false
  nullable    = false
}

