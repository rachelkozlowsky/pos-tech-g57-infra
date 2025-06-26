resource "aws_eks_access_entry" "access_entry" {
  cluster_name      = aws_eks_cluster.cluster.name
  principal_arn     = data.aws_iam_user.github_user.arn
  kubernetes_groups = ["group-57", "group-soat"]
  type              = "STANDARD"
}

resource "aws_eks_access_policy_association" "access_entry_association" {
  cluster_name  = aws_eks_cluster.cluster.name
  policy_arn    = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSAdminPolicy"
  principal_arn = data.aws_iam_user.github_user.arn

  access_scope {
    type       = "cluster"
  }
}

resource "aws_eks_cluster" "cluster" {
  name = "eks-${var.project_name}"

  access_config {
    authentication_mode = "API" #ou configMap
  }

  role_arn = aws_iam_role.postechfiap.arn
  version  = "1.31"

  vpc_config {
    subnet_ids = [
      aws_subnet.public[0].id,
      aws_subnet.public[1].id,
      aws_subnet.public[2].id,
    ]
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_policy_attachment,
  ]
}

resource "aws_eks_node_group" "node_group" {
  cluster_name    = aws_eks_cluster.cluster.name
  node_group_name = "node-group-${var.project_name}"
  node_role_arn   = aws_iam_role.postechfiap.arn
  subnet_ids      = [aws_subnet.public[0].id, aws_subnet.public[1].id, aws_subnet.public[2].id]
  instance_types = [var.instance_type]
  disk_size = 50

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks_node_worker_policy_attachment,
    aws_iam_role_policy_attachment.eks_node_cni_policy_attachment,
    aws_iam_role_policy_attachment.eks_node_ecr_policy_attachment,
  ]
}