# main.tf

provider "aws" {
  region  = "us-east-1"
  #profile = "terraform-demo"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr                 = "10.0.0.0/16"
  public_subnet_count      = 2
  private_subnet_count     = 2
  public_subnet_name_prefix = "eks-public-subnet"
  private_subnet_name_prefix = "eks-private-subnet"
  nat_gw_count             = 1
}

module "iam" {
  source = "./modules/iam"
}

module "eks" {
  source           = "./modules/eks"
  cluster_role_arn = module.iam.cluster_role_arn
  node_role_arn    = module.iam.node_role_arn
  subnet_ids       = module.vpc.private_subnets
}
