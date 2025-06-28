data "aws_region" "current" {
}

data "aws_caller_identity" "current" {
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.cluster.name
}

data "aws_iam_user" "github_user" {
  user_name = "github"
}

