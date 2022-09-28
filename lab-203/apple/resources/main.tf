locals {
  name_prefix = format("%s-%s", var.project, var.region_code)

  tags = {
    Project     = var.project
    Environment = var.env
    Team        = var.team
    Owner       = var.owner
    ManagedBy   = "Terraform"
  }
}

module "vpc" {
  source      = "./10-vpc/"
  #
  project     = var.project
  region_code = var.region_code
  cidr        = var.cidr
  tags        = local.tags
}

module "bastion" {
  source      = "./20-bastion/"
  #
  project     = var.project
  region_code = var.region_code
  tags        = local.tags
  vpc_id      = module.vpc.vpc_id

  depends_on = [module.vpc]
}

module "alb" {
  source      = "./30-alb/"
  #
  domain      = "btcdemo.ml"
  project     = var.project
  region_code = var.region_code
  tags        = local.tags
  vpc_id      = module.vpc.vpc_id

  depends_on = [module.vpc]
}
