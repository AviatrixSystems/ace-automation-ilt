variable "deploy_mcna" {
  description = "Set to true to deploy a fully connected multicloud network architecture"
  type        = bool
  default     = true
  nullable    = false
}

variable "enable_firenet" {
  description = "Set to true to insert PAN into the east-west data path"
  type        = bool
  default     = false
  nullable    = false
}

variable "apply_segmentation" {
  description = "Set to true to apply network segmentation to isolate spoke networks"
  type        = bool
  default     = false
  nullable    = false
}

variable "apply_policy" {
  description = "Set to true to connect segmented networks"
  type        = bool
  default     = false
  nullable    = false
}

variable "enable_dcf" {
  description = "Set to true to enable dcf and apply a set of distributed firewall policies"
  type        = bool
  default     = false
  nullable    = false
}

variable "enable_dcf_tag_rule" {
  description = "Set to true enable a dcf policy acting on tagged resources"
  type        = bool
  default     = false
  nullable    = false
}

variable "enable_sg_orchestration" {
  description = "Set to true to micosegment spoke networks"
  type        = bool
  default     = false
  nullable    = false
}

variable "apply_custom_spoke_routing" {
  description = "Set to true to apply custom routing to spoke networks"
  type        = bool
  default     = false
  nullable    = false
}

variable "pod_number" {
  description = "The pod number assigned at pod registration"
  type        = string
  nullable    = false
}

variable "controller_password" {
  description = "The Aviatrix student password assigned at pod registration"
  type        = string
  nullable    = false
}

variable "firewall_password" {
  description = "The firewall student password assigned at pod registration"
  type        = string
  nullable    = false
}
