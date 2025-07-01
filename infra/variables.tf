variable "projectName" {
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
