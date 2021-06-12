provider "aws" {
  region = var.aws_region
}

provider "aws" {
  alias           = "us_east_1"
  region          = "us-east-1"
}

data "aws_caller_identity" "current" {}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
  comment = "Origin Access for s3"
}

resource "aws_acm_certificate" "cert" {
  provider        = "aws.us_east_1"
  domain_name       = var.dist_aliases[0]
  validation_method = "DNS"

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }
}

# data "aws_acm_certificate" "issued" {
#   provider        = "aws.us_east_1"
#   domain   = var.dist_aliases[0]
#   statuses = ["ISSUED"]
# }
