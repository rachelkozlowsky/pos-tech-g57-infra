# ======================================
# AWS Certificate Manager (ACM) Configuration
# ======================================

# Certificado SSL para o domínio pos-tech-g57-food-app.com.br e subdomínios
resource "aws_acm_certificate" "main" {
  domain_name       = var.domain_name
  subject_alternative_names = [
    "*.${var.domain_name}",
    "www.${var.domain_name}",
    "api.${var.domain_name}"
  ]
  validation_method = "DNS"

  tags = merge(var.tags, {
    Name = "${var.projectName}-ssl-certificate"
    Type = "SSL Certificate"
  })

  lifecycle {
    create_before_destroy = true
  }
}

