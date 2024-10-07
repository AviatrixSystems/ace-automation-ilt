variable "azure_spoke_vpc_id" {
  description = "Azure spoke vpc id"
  type        = string
}

variable "aws_spoke_vpc_id" {
  description = "AWS spoke vpc id"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "azure_region" {
  description = "Azure region"
  type        = string
}

variable "aws_account" {
  description = "AWS account name registered in Aviatrix"
  type        = string
}

variable "azure_account" {
  description = "Azure account name registered in Aviatrix"
  type        = string
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
