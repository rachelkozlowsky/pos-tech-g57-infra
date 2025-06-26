# variable "oidc"{
#   type = string
# }

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
  default     = "fiap-postech-g57"
}

variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "cidr_subnet_public" {
  description = "CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "cidr_subnet_private" {
  description = "CIDR block for the private subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "tags" {
  default = {
    Name = "fiap-postech-g57"
  }
}

variable "instance_type" {
  default = "t3.medium"
}


variable "kubernetes_namespace" {
  description = "The Kubernetes namespace to use"
  type        = string
  default     = "eks-postechfiap"
}

variable "cluster_name" {
    description = "The name of the EKS cluster"
    type        = string
    default     = "eks-cluster-postechfiap"
}