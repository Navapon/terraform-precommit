terraform {
  required_providers {
    aws = {
      source  = "aws"
      version = "~>5.80"
    }
  }

  required_version = ">= 1.8"
}

provider "aws" {
  region = "ap-southeast-7"

  default_tags {
    tags = {
    }
  }
}
