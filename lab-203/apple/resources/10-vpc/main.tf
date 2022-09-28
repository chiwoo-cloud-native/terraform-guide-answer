locals {
  name_prefix = format("%s-%s", var.project, var.region_code)
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.16.0"

  name = format("%s-vpc", local.name_prefix)
  cidr = "${var.cidr}.0.0/16"
  #
  azs  = [
    data.aws_availability_zones.this.zone_ids[0], data.aws_availability_zones.this.zone_ids[1]
  ]
  enable_dns_hostnames         = true
  enable_dns_support           = true
  #
  enable_nat_gateway           = true
  single_nat_gateway           = true
  public_subnets               = ["${var.cidr}.11.0/24", "${var.cidr}.12.0/24"]
  public_subnet_suffix         = "pub"
  private_subnets              = ["${var.cidr}.21.0/24", "${var.cidr}.22.0/24"]
  private_subnet_suffix        = "app"
  database_subnets             = ["${var.cidr}.91.0/24", "${var.cidr}.92.0/24"]
  database_subnet_suffix       = "data"
  create_database_subnet_group = false

  tags = merge(var.tags, {}  )

}
