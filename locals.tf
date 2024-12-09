locals {
  controller_username   = "student"
  firewall_username     = "student"
  controller_fqdn_or_ip = "ctrl.${var.pod_number}.aviatrixlab.com"

  backbone = {
    aws = {
      transit_name                                 = "transit-aws"
      transit_account                              = "aws-account"
      transit_cloud                                = "aws"
      transit_instance_size                        = "c5n.xlarge"
      transit_cidr                                 = "10.1.0.0/23"
      transit_region_name                          = "us-east-1"
      transit_asn                                  = 65101
      firenet                                      = var.enable_firenet
      firenet_firewall_image                       = "Palo Alto Networks VM-Series Next-Generation Firewall (BYOL)"
      firenet_bootstrap_bucket_name_1              = "${var.pod_number}.bootstrap.aviatrixlab.com"
      firenet_iam_role_1                           = "aviatrix-bootstrap-VM-S3-role"
      firenet_inspection_enabled                   = true
      firenet_keep_alive_via_lan_interface_enabled = true
    },
    azure = {
      transit_name        = "transit-azure"
      transit_account     = "azure-account"
      transit_cloud       = "azure"
      transit_cidr        = "10.2.0.0/23"
      transit_region_name = "West US"
      transit_asn         = 65102
      transit_az_support  = false
    },
  }
}
