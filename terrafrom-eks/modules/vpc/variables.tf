variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name of the VPC"
  default     = "main-vpc"
}

variable "igw_name" {
  description = "Name of the Internet Gateway"
  default     = "main-igw"
}

variable "public_subnet_count" {
  description = "Number of public subnets"
  default     = 3
}

variable "public_subnet_name_prefix" {
  description = "Name prefix for public subnets"
  default     = "public-subnet"
}

variable "public_rt_name" {
  description = "Name for the public route table"
  default     = "public-rt"
}

variable "private_subnet_count" {
  description = "Number of private subnets"
  default     = 3
}

variable "private_subnet_name_prefix" {
  description = "Name prefix for private subnets"
  default     = "private-subnet"
}

variable "private_rt_name" {
  description = "Name for the private route table"
  default     = "private-rt"
}

variable "nat_gw_count" {
  description = "Number of NAT Gateways"
  default     = 1
}

variable "nat_gw_name" {
  description = "Name for the NAT Gateway"
  default     = "nat-gw"
}
