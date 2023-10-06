terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.52.0"
    }
  }
  required_version = ">= 1.1.0"
}

provider "aws" {
  region = "us-west-2"
}

locals {
  companylist = toset(split("\n", trim(lower(file("./companies")), "\n")))
}

resource "aws_s3_bucket" "example" {
  for_each = local.companylist
  bucket = "company-${each.key}"
}


resource "aws_s3_bucket_public_access_block" "example" {
  for_each = local.companylist
  bucket = aws_s3_bucket.example[each.key].id
  block_public_acls   = false
  block_public_policy = false
}
