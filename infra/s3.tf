resource "aws_s3_bucket" "bucket-backend-postech-g57" {
  bucket = "tfstate-backend-postech-g57"
  tags   = var.tags
}