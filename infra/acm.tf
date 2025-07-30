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

# Validação do certificado SSL via DNS
resource "aws_acm_certificate_validation" "main" {
  certificate_arn         = aws_acm_certificate.main.arn
  validation_record_fqdns = [for record in aws_route53_record.cert_validation : record.fqdn]

  timeouts {
    create = "10m"
  }

  depends_on = [aws_route53_record.cert_validation]
}

