terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.27.0"
    }
     cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 5.15.0"
    }
  }
}

provider "aws" {
  region = "eu-west-2"
}
