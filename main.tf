terraform {
    required_providers {
        aws = {
        source  = "hashicorp/aws"
        version = "~> 5.0"
        }
    }
    required_version = ">= 1.2.0"
}
provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  public_subnet_azs = var.public_subnet_azs
}

module "security" {
  source = "./modules/security"
  
  vpc_id = module.vpc.vpc_id
}


module "openproject" {
  source = "./modules/UC-03-openproject"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  security_group_ids = [module.security.instance_sg_id]
  instance_type      = var.instance_type
  key_name           = var.key_name
  ami_id             = var.ami_id
}

module "devlake" {
  source = "./modules/UC-04-devlake"

  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
  security_group_ids = [module.security.instance_sg_id]
  instance_type      = var.instance_type
  key_name           = var.key_name
  ami_id             = var.ami_id
}

module "alb" {
  source = "./modules/alb"

  vpc_id                = module.vpc.vpc_id
  public_subnet_ids     = module.vpc.public_subnet_ids
  security_group_id     = module.security.alb_sg_id
  openproject_instance  = module.openproject.instance_id
  devlake_instance      = module.devlake.instance_id
}