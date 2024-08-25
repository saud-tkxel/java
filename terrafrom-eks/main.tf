provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.13.0"  # Updated to the latest version
  name    = "myapp-vpc"
  cidr    = "10.0.0.0/16"
  azs     = ["us-east-1a", "us-east-1b", "us-east-1c"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  private_subnets = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  version         = "19.18.0"
  cluster_name    = "myapp-eks"
  cluster_version = "1.27"
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.private_subnets

  # Enabling IAM Roles for Service Accounts (IRSA)
  enable_irsa = true
}

resource "aws_iam_role" "eks_node_group" {
  name = "myapp-eks-node-group-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        },
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_node_group_policy" {
  role      = aws_iam_role.eks_node_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role      = aws_iam_role.eks_node_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

module "eks_managed_node_group" {
  source = "terraform-aws-modules/eks/aws//modules/eks-managed-node-group"
  version = "19.18.0"

  name            = "myapp-node-group"
  cluster_name    = module.eks.cluster_name
  cluster_version = module.eks.cluster_version
  subnet_ids      = module.vpc.private_subnets

  cluster_primary_security_group_id = module.eks.cluster_primary_security_group_id
  vpc_security_group_ids            = [module.eks.node_security_group_id]

  min_size     = 1
  max_size     = 3
  desired_size = 2

  instance_types = ["t3.medium"]
  capacity_type  = "ON_DEMAND"

  iam_role_arn = aws_iam_role.eks_node_group.arn

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = module.vpc.vpc_id
}

# Create a Route Table for Public Subnets
resource "aws_route_table" "public" {
  vpc_id = module.vpc.vpc_id
}

# Create a Route to the Internet Gateway
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main.id
}

# Associate the Route Table with Public Subnets
resource "aws_route_table_association" "public_subnets" {
  count          = length(module.vpc.public_subnets)
  subnet_id      = module.vpc.public_subnets[count.index]
  route_table_id = aws_route_table.public.id
}

# Create a Route Table for Private Subnets
resource "aws_route_table" "private" {
  vpc_id = module.vpc.vpc_id
}

# Fetch NAT Gateway ID
data "aws_nat_gateway" "example" {
  filter {
    name   = "vpc-id"
    values = [module.vpc.vpc_id]
  }
}

# Create a Route to the NAT Gateway
resource "aws_route" "nat_gateway" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = data.aws_nat_gateway.example.id
}

# Associate the Route Table with Private Subnets
resource "aws_route_table_association" "private_subnets" {
  count          = length(module.vpc.private_subnets)
  subnet_id      = module.vpc.private_subnets[count.index]
  route_table_id = aws_route_table.private.id
}
