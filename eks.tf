module "eks" {

  #import module from terraform-aws-modules/eks/aws
  source = "terraform-aws-modules/eks/aws"

  version = "~> 20.31"

  # cluster info
  cluster_name    = "${local.name}-${local.env}-eks"
  cluster_version = "1.31"

  cluster_endpoint_public_access = true

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.intra_subnets


  cluster_addons = {
    vpc_cni = {
      most-recent = true
    }
    kube_proxy = {
      most-recent = true
    }
    coredns = {
      most-recent = true
    }
  }

  # manage node in cluster 
  eks_managed_node_group_defaults = {
    instance_type = ["t2.micro"]
    attach_cluster_primary_security_group = true
  }

  eks_managed_node_groups = {
    cluster-ng = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      instance_types = ["t2.micro"]

      min_size     = 2
      max_size     = 3
      desired_size = 2

      capacity_type = "SPOT"
    }
  }


  tags = {
    Terraform   = "true"
    Environment = local.env
  }
}
