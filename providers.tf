provider "aviatrix" {
  username      = local.controller_username
  password      = var.controller_password
  controller_ip = local.controller_fqdn_or_ip
}
