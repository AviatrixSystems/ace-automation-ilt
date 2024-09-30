variable "enable_firenet" {}
variable "apply_segmentation" {}
variable "apply_policy" {}
variable "enable_dcf" {}
variable "enable_dcf_tag_rule" {}
variable "enable_sg_orchestration" {}
variable "apply_custom_spoke_routing" {}
variable "pod_number" {}
variable "controller_password" {}
variable "firewall_password" {}
variable "deploy_mcna" {
  description = ""
  type        = bool
  default     = true
  nullable    = false

  # validation {
  #   condition     = var.cidr != "" ? can(cidrnetmask(var.cidr)) : true
  #   error_message = "This does not like a valid CIDR."
  # }
}
