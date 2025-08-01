variable "projectName" {
    type  = string
  default = "postech-g57"
}

variable "region_default" {
  default = "us-east-1"
}

variable "cidr_vpc" {
  default = "10.0.0.0/16"
}

variable "tags" {
  default = {
    Name = "postech-g57-fiap",
    School = "FIAP",
    Environment = "Production",
    Year = "2025"
  }
}

variable "instance_type" {
  default = "t3.medium"
}

variable "user_name" {
  type    = string
  default = "postech"
}

variable "bucket_name" {
  type    = string
  default = "tfstate-backend-postech-g57"
}

variable "domain_name" {
  description = "Domain name for the application"
  type        = string
  default     = "pos-tech-g57-food-app.com.br"
}


