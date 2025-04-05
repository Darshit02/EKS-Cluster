module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${local.name}-${local.env}-vpc"
  cidr = local.vpc_cider

  azs             = local.azs
  private_subnets = local.private_subnets
  public_subnets  = local.public_subnets
  intra_subnets   = local.intra_subnet

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform   = "true"
    Environment = local.env
  }
}
