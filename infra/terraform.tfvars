# This file contains the variable values for the Terraform configuration.
projectName = "postech-g57" # Nome do projeto
user_name = "postech" # Nome do usuário IAM
bucket_name = "tfstate-backend-postech-g57" # Nome do bucket S3, usado para armazenar o estado do Terraform
region_default = "us-east-1" # Região padrão da AWS
tags = {
  Name = "postech-g57-fiap",
  School = "FIAP",
  Environment = "Production",
  Year = "2025"
} # Tags para os recursos criados