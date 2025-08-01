# Infraestrutura como Código - Projeto FIAP Pós-Tech G57

Este repositório contém a infraestrutura como código (IaC) para o projeto da Pós-Tech da FIAP, utilizando Terraform para provisionamento na AWS.

Recursos criados incluem:
- Cluster EKS (Elastic Kubernetes Service)
- Configuração de acesso ao cluster EKS
- Configuração de nós do EKS
- Sub-redes, VPC e Internet Gateway
- Tabelas de roteamento
- Application Load Balancer (ALB)
- Buckets S3 para armazenamento de estado do Terraform
- IAM Roles e Policies
- Security Groups
- DynamoDB

## 📂 Estrutura do Projeto

```
. 
├── .github/  
│ └── workflows/ 
│   └── develop-to-main.yaml      # Configuração do GitHub Actions 
|   └── feture-to-develop.yaml    # Configuração do GitHub Actions 
|   └── main-apply.yaml           # Configuração do GitHub Actions 
|   └── release-versioning.yaml   # Configuração do GitHub Actions 
│ └── CODEOWNERS                  # Definição de responsáveis pelo código
├── infra/
│ ├── access-entry.tf    # Configuração de acesso ao cluster EKS 
│ ├── alb.tf             # Configuração do Application Load Balancer (ALB) 
│ ├── backend.tf         # Configuração do backend S3 para armazenamento do estado 
│ ├── data.tf            # Fontes de dados para consulta de recursos existentes 
│ ├── dynamodb.tf        # Configuração do DynamoDB
│ ├── eks-cluster.tf     # Configuração do cluster EKS 
│ ├── eks-node.tf        # Configuração dos nós do EKS 
│ ├── iam-role.tf        # Definição de IAM Roles e Policies 
│ ├── internet-g.tf      # Configuração do Internet Gateway 
| ├── output.tf          # Definição de outputs para exibição após o deploy
│ ├── provider.tf        # Configuração do provedor AWS
│ ├── route-t.tf         # Tabelas de roteamento 
│ ├── s3.tf              # Configuração do bucket S3 para o estado do Terraform
│ ├── sg.tf              # Security Groups 
│ ├── subnet.tf          # Definição das sub-redes 
│ ├── terraform.tfvars   # Valores das variáveis de configuração 
│ ├── variables.tf       # Definição de variáveis 
│ └── vpc.tf             # Configuração da VPC 
└── README.md            # Documentação do projeto

```

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- [Terraform](https://www.terraform.io/downloads.html) (versão 1.0+)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) configurada com credenciais válidas
- Acesso a uma conta AWS com permissões adequadas (AdministratorAccess)
- Git para controle de versão

## 🛠️ Instalação
### 1. Clone o repositório

```bash
git clone https://github.com/rachelkozlowsky/pos-tech-g57-infra.git 
cd pos-tech-g57-infra/infra
```
### 2. Configure as credenciais da AWS

Certifique-se de que suas credenciais AWS estão configuradas:

```bash
aws configure
```

Será solicitado:
- AWS Access Key ID
- AWS Secret Access Key
- Região padrão (us-east-1)
- Formato de saída (deixe em branco para o padrão json)

### 3. Personalize as variáveis

Edite o arquivo `terraform.tfvars` com as configurações desejadas, lembre-se de mudar o nome do **bucket_name**:

```hcl
projectName = "postech-g57"                  # Nome do projeto
user_name = "seu-usuario-iam"                # Nome do usuário IAM com permissões adequadas
bucket_name = "tfstate-backend-postech-g57"  # Nome do bucket S3 para o estado do Terraform (deve ser único globalmente)
```


## 🚀 Executando a Infraestrutura

### 1. Inicialize o Terraform

```bash
terraform init
```

### 2. Verifique as alterações planejadas

```bash
terraform plan
```

### 3. Aplique a infraestrutura

```bash
terraform apply
```

Confirme a execução digitando `yes` quando solicitado.


### Configuração do Backend S3 (Opcional)

1. **O bloco do backend está comentado** em backend.tf
   ```hcl
   # terraform {
   #   backend "s3" {
   #     bucket = "seu-bucket-aqui"
   #     key    = "backend/tfstate"
   #     region = "us-east-1"
   #   }
   # }
    ```
    Isso é necessário para a primeira execução, pois o bucket S3 ainda não existe.

2. **Descomente o bloco do S3.tf** para aplicar a configuração do bucket S3:
   ```hcl
    resource "aws_s3_bucket" "bucket-backend-postech-g57" {
      bucket = var.bucket_name
      tags   = var.tags
    }
   ```
   E certifique-se de que o nome do bucket é único globalmente.
   Aplique a configuração do bucket S3:
   ```bash
    terraform init
    terraform plan
    terraform apply
    ```

3. **Atualize o arquivo `backend.tf`** para incluir o bucket S3 criado:
   ```hcl
   terraform {
     backend "s3" {
       bucket = "seu-bucket-aqui"
       key    = "backend/tfstate"
       region = "us-east-1"
     }
   }
   ```
   
4. **Migre o estado do Terraform para o S3:** 
   ```bash
   terraform init -migrate-state
   ```
   Execute novamente os comandos `terraform plan` e `terraform apply` para garantir que tudo esteja configurado corretamente.


## 🧹 Limpeza dos Recursos

Para remover todos os recursos criados:

```bash
terraform destroy
```

## 🔄 Fluxo de Trabalho com GitHub Actions

O projeto inclui um workflow do GitHub Actions que pode ser configurado para execução automática. Os arquivos de configuração estão localizados em `.github/workflows/`.

### Variáveis de Ambiente Necessárias

Configure os seguintes segredos no repositório do GitHub (Settings > Secrets > Actions):

- `AWS_ACCESS_KEY_ID` - Sua AWS Access Key ID
- `AWS_SECRET_ACCESS_KEY` - Sua AWS Secret Access Key
- `AWS_DEFAULT_REGION` - Região AWS (padrão: us-east-1)

## 🔒 Segurança

- Nunca faça commit de credenciais ou arquivos sensíveis
- Utilize variáveis de ambiente para dados sensíveis
- Mantenha suas credenciais AWS seguras e rotacione-as regularmente

## 🤝 Contribuição

1. Crie um fork do projeto
2. Crie uma branch para sua feature (`git checkout -b feature/AmazingFeature`)
3. Faça commit das suas alterações (`git commit -m 'Add some AmazingFeature'`)
4. Dê push para a branch (`git push origin feature/AmazingFeature`)
5. O Pull Request é aberto automaticamente para revisão

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 📞 Suporte

Para suporte, entre em contato com a equipe de desenvolvimento.
