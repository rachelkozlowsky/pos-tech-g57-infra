# data "aws_eks_cluster" "postechfiap"{
#   name = var.cluster_name
# }

data "aws_region" "current" {
}

data "aws_caller_identity" "current" {
}

# data "aws_eks_cluster" "this"{
#   name = var.cluster_name
# }

data "aws_eks_cluster_auth" "this"{
  name = var.cluster_name
}

data "aws_iam_user" "github_user"{
    user_name = "github"
}

