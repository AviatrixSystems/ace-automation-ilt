# Distributed firewall
resource "aviatrix_distributed_firewalling_config" "enable" {
  enable_distributed_firewalling = true
}

resource "aviatrix_smart_group" "inter_cloud" {
  name = "inter-cloud"
  selector {
    match_expressions {
      type = "vm"
      tags = {
        Allowxcloud = "true"
      }
    }
    match_expressions {
      type = "vm"
      tags = {
        allowxcloud = "true"
      }
    }
  }
}

resource "aviatrix_smart_group" "aws_intra_vpc" {
  name = "aws-intra-vpc"
  selector {
    match_expressions {
      type = "vm"
      tags = {
        Allow-aws-intra-vpc = "true"
      }
    }
    match_expressions {
      type = "vm"
      tags = {
        allow-aws-intra-vpc = "true"
      }
    }
  }
}

resource "aviatrix_smart_group" "azure_intra_vpc" {
  name = "azure-intra-vpc"
  selector {
    match_expressions {
      type = "vm"
      tags = {
        Allow-azure-intra-vpc = "true"
      }
    }
    match_expressions {
      type = "vm"
      tags = {
        allow-azure-intra-vpc = "true"
      }
    }
  }
}

resource "aviatrix_smart_group" "aws_spoke" {
  name = "aws-spoke"
  selector {
    match_expressions {
      cidr = "10.1.2.0/24"
    }
    match_expressions {
      cidr = "172.16.0.0/12"
    }
  }
}

resource "aviatrix_smart_group" "azure_spoke" {
  name = "azure-spoke"
  selector {
    match_expressions {
      cidr = "10.2.2.0/24"
    }
  }
}

resource "aviatrix_distributed_firewalling_policy_list" "dcf" {
  policies {
    name     = "allow-https"
    action   = "PERMIT"
    priority = 100
    protocol = "TCP"
    port_ranges {
      lo = 443
    }
    logging = true
    watch   = false
    src_smart_groups = [
      aviatrix_smart_group.aws_spoke.uuid,
      aviatrix_smart_group.azure_spoke.uuid
    ]
    dst_smart_groups = [
      aviatrix_smart_group.aws_spoke.uuid,
      aviatrix_smart_group.azure_spoke.uuid
    ]
  }

  policies {
    name     = "allow-sql-xcloud"
    action   = "PERMIT"
    priority = 200
    protocol = "TCP"
    port_ranges {
      lo = 1433
    }
    logging = true
    watch   = var.enable_dcf_tag_rule ? false : true
    src_smart_groups = [
      aviatrix_smart_group.inter_cloud.uuid,
    ]
    dst_smart_groups = [
      aviatrix_smart_group.inter_cloud.uuid,
    ]
  }

  policies {
    name     = "allow-sql-aws-intra-vpc"
    action   = "PERMIT"
    priority = 300
    protocol = "TCP"
    port_ranges {
      lo = 1433
    }
    logging = true
    watch   = false
    src_smart_groups = [
      aviatrix_smart_group.aws_intra_vpc.uuid,
    ]
    dst_smart_groups = [
      aviatrix_smart_group.aws_intra_vpc.uuid,
    ]
  }

  policies {
    name     = "allow-sql-azure-intra-vpc"
    action   = "PERMIT"
    priority = 400
    protocol = "TCP"
    port_ranges {
      lo = 1433
    }
    logging = true
    watch   = false
    src_smart_groups = [
      aviatrix_smart_group.azure_intra_vpc.uuid,
    ]
    dst_smart_groups = [
      aviatrix_smart_group.azure_intra_vpc.uuid,
    ]
  }

  policies {
    name                     = "default-deny-all"
    action                   = "DENY"
    priority                 = 2147483646
    protocol                 = "Any"
    logging                  = true
    watch                    = false
    exclude_sg_orchestration = true
    src_smart_groups = [
      "def000ad-0000-0000-0000-000000000000" # Anywhere
    ]
    dst_smart_groups = [
      "def000ad-0000-0000-0000-000000000000" # Anywhere
    ]
  }
  depends_on = [
    aviatrix_distributed_firewalling_config.enable
  ]
}

resource "aviatrix_distributed_firewalling_intra_vpc" "enable" {
  count = var.enable_sg_orchestration ? 1 : 0
  vpcs {
    account_name = var.azure_account
    vpc_id       = var.azure_spoke_vpc_id
    region       = var.azure_region
  }
  vpcs {
    account_name = var.aws_account
    vpc_id       = var.aws_spoke_vpc_id
    region       = var.aws_region
  }
}
