provider "aws" {
  region = "us-east-1"
}

terraform {
  required_version = ">= 1.4.2"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.89.0"
    }
  }
}

# provider "kubernetes" {
#   host                   = aws_eks_cluster.cluster.endpoint
#   cluster_ca_certificate = base64decode(aws_eks_cluster.cluster.certificate_authority[0].data)
#   token                  = data.aws_eks_cluster_auth.cluster.token
# }