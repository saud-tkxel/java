# Root outputs.tf

output "vpc_id" {
  description = "The ID of the VPC created by the VPC module"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "List of public subnet IDs created by the VPC module"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "List of private subnet IDs created by the VPC module"
  value       = module.vpc.private_subnets
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway created by the VPC module"
  value       = module.vpc.nat_gateway_id
}

output "eks_cluster_name" {
  description = "The name of the EKS cluster created by the EKS module"
  value       = module.eks.eks_cluster_name
}

output "eks_cluster_endpoint" {
  description = "The endpoint of the EKS cluster created by the EKS module"
  value       = module.eks.eks_cluster_endpoint
}

output "eks_node_group_name" {
  description = "The name of the EKS node group created by the EKS module"
  value       = module.eks.eks_node_group_name
}

output "eks_cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster created by the IAM module"
  value       = module.iam.cluster_role_arn
}

output "eks_node_role_arn" {
  description = "IAM role ARN for EKS nodes created by the IAM module"
  value       = module.iam.node_role_arn
}
