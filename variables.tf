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
  validation {
    condition     = var.enable_firenet && !var.deploy_mcna ? false : true
    error_message = "Variable deploy_mcna must be true for enable_firenet to be true"
  }
}

variable "apply_segmentation" {
  description = "Set to true to apply network segmentation to isolate spoke networks"
  type        = bool
  default     = false
  nullable    = false
  validation {
    condition     = var.apply_segmentation && !var.deploy_mcna ? false : true
    error_message = "Variable deploy_mcna must be true for apply_segmentation to be true"
  }
}

variable "apply_policy" {
  description = "Set to true to connect segmented networks"
  type        = bool
  default     = false
  nullable    = false
  validation {
    condition     = var.apply_policy && !var.deploy_mcna ? false : true
    error_message = "Variable deploy_mcna must be true for apply_policy to be true"
  }
  validation {
    condition     = var.apply_policy && !var.apply_segmentation ? false : true
    error_message = "Variable apply_segmentation must be true for apply_policy to be true"
  }
}

variable "enable_dcf" {
  description = "Set to true to enable dcf and apply a set of distributed firewall policies"
  type        = bool
  default     = false
  nullable    = false
  validation {
    condition     = var.enable_dcf && !var.deploy_mcna ? false : true
    error_message = "Variable deploy_mcna must be true for enable_dcf to be true"
  }
}

variable "enable_dcf_tag_rule" {
  description = "Set to true enable a dcf policy acting on tagged resources"
  type        = bool
  default     = false
  nullable    = false
  validation {
    condition     = var.enable_dcf_tag_rule && !var.deploy_mcna ? false : true
    error_message = "Variable deploy_mcna must be true for enable_dcf_tag_rule to be true"
  }
  validation {
    condition     = var.enable_dcf_tag_rule && !var.enable_dcf ? false : true
    error_message = "Variable enable_dcf must be true for enable_dcf_tag_rule to be true"
  }
}

variable "enable_sg_orchestration" {
  description = "Set to true to micosegment spoke networks"
  type        = bool
  default     = false
  nullable    = false
  validation {
    condition     = var.enable_sg_orchestration && !var.deploy_mcna ? false : true
    error_message = "Variable deploy_mcna must be true for enable_sg_orchestration to be true"
  }
  validation {
    condition     = var.enable_sg_orchestration && !var.enable_dcf ? false : true
    error_message = "Variable enable_dcf must be true for enable_sg_orchestration to be true"
  }
}

variable "apply_custom_spoke_routing" {
  description = "Set to true to apply custom routing to spoke networks"
  type        = bool
  default     = false
  nullable    = false
  validation {
    condition     = var.apply_custom_spoke_routing && !var.deploy_mcna ? false : true
    error_message = "Variable deploy_mcna must be true for apply_custom_spoke_routing to be true"
  }
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
