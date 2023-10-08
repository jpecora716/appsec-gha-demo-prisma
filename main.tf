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
  bucket   = "company-${each.key}"
  tags = {
    git_commit           = "715560f21546b0c5b74a1b461dfcaed7d8d96b95"
    git_file             = "main.tf"
    git_last_modified_at = "2023-10-06 12:54:00"
    git_last_modified_by = "jpecora@paloaltonetworks.com"
    git_modifiers        = "jpecora"
    git_org              = "jpecora716"
    git_repo             = "appsec-gha-demo-prisma"
    yor_name             = "example"
    yor_trace            = "25468e1f-76ea-431c-a9f0-fab2994896db"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  for_each            = local.companylist
  bucket              = aws_s3_bucket.example[each.key].id
  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket" "financials" {
  for_each = local.companylist
  bucket   = "company-financials-${each.key}"
  tags = {
    git_commit           = "9939eab4b032d537810145e062102ad394213a99"
    git_file             = "main.tf"
    git_last_modified_at = "2023-10-06 20:49:05"
    git_last_modified_by = "jpecora@paloaltonetworks.com"
    git_modifiers        = "jpecora"
    git_org              = "jpecora716"
    git_repo             = "appsec-gha-demo-prisma"
    yor_name             = "financials"
    yor_trace            = "2b6d72a4-fe61-42af-83de-4e72a92c5d07"
  }
}

resource "aws_s3_bucket_public_access_block" "financials" {
  for_each            = local.companylist
  bucket              = aws_s3_bucket.financials[each.key].id
  block_public_acls   = false
  block_public_policy = false
}

resource "aws_s3_bucket" "hr" {
  for_each = local.companylist
  bucket = "company-humanresources-${each.key}"
}

resource "aws_s3_bucket_public_access_block" "hr" {
  for_each = local.companylist
  bucket = aws_s3_bucket.hr[each.key].id
  block_public_acls   = false
  block_public_policy = false
}
