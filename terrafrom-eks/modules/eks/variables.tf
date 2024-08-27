variable "cluster_name" {
  description = "EKS cluster name"
  default     = "eks-cluster"
}

variable "node_group_name" {
  description = "EKS node group name"
  default     = "eks-node-group"
}

variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS cluster"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for EKS nodes"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs"
  type        = list(string)
}

variable "desired_capacity" {
  description = "Desired capacity for EKS node group"
  default     = 2
}

variable "max_capacity" {
  description = "Maximum capacity for EKS node group"
  default     = 3
}

variable "min_capacity" {
  description = "Minimum capacity for EKS node group"
  default     = 1
}
