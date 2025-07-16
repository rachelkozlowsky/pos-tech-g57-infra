# Criação do Secret no AWS Secrets Manager
resource "aws_secretsmanager_secret" "api_secrets" {
  name        = "prod/api-secrets"
  description = "Segredos da aplicação API"
  kms_key_id  = "alias/aws/secretsmanager"

  tags = var.tags
}

# Versão do Secret
resource "aws_secretsmanager_secret_version" "api_secrets_version" {
  secret_id = aws_secretsmanager_secret.api_secrets.id
  secret_string = jsonencode({
    JWT_TOKEN_PIX_APPLICATION_PAYMENT = "QVBQX1VTUi0zMjY4NzY2MDEzMDA5OTgzLTA0MjcxMS1kYTM1ODdhZTg2ZDg3ZGJjMjFiZWY0ZDI4YTE5NDc5MC0yNDA4MTI4NzIx"
  })
}

resource "aws_iam_policy" "eks_secrets_policy" {
  name        = "EKSSecretsManagerPolicy"
  description = "Permite que o EKS acesse os segredos da aplicação"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret"
        ]
        Effect = "Allow"
        Resource = [
          aws_secretsmanager_secret.api_secrets.arn
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_secrets_attachment" {
  policy_arn = aws_iam_policy.eks_secrets_policy.arn
  role       = aws_iam_role.node.name
}