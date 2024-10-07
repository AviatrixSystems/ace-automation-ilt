variable "azure_transit_gw_name" {
  description = "Azure transit gateway name"
  type        = string
}

variable "aws_transit_gw_name" {
  description = "AWS transit gateway name"
  type        = string
}

variable "azure_spoke_gw_name" {
  description = "Azure spoke gateway name"
  type        = string
}

variable "aws_spoke_gw_name" {
  description = "AWS spoke gateway name"
  type        = string
}

variable "apply_policy" {
  description = "Set to true to connect segmented networks"
  type        = bool
  default     = false
  nullable    = false
}

