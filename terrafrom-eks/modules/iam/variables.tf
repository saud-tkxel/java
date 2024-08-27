variable "cluster_role_name" {
  description = "Name of the EKS cluster IAM role"
  default     = "eks-cluster-role"
}

variable "node_role_name" {
  description = "Name of the EKS node IAM role"
  default     = "eks-node-group-role"
}
