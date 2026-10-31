# declaring terraform block for terraform and prvider version constrains. 

terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }

    null = {
      source  = "hashicorp/null"
      version = "3.3.2"
    }
  }
}

provider "aws" {
  region = var.region
}