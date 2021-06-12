locals {
  s3_origin_id = "www"
}

resource "aws_s3_bucket" "www" {
  bucket = "${var.bucket_name_prefix}-${data.aws_caller_identity.current.account_id}"
  acl    = "private"
  tags = merge({
    Name = "${var.bucket_name_prefix}-${data.aws_caller_identity.current.account_id}"
  },
  var.tags)
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}

data "aws_iam_policy_document" "s3_policy" {
  statement {
    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.www.arn}/*"]

    principals {
      type        = "AWS"
      identifiers = [aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn]
    }
  }
}

resource "aws_s3_bucket_policy" "www_policy" {
  bucket = aws_s3_bucket.www.id
  policy = data.aws_iam_policy_document.s3_policy.json
}

resource "aws_s3_bucket" "logs" {
  bucket = "${var.bucket_name_prefix}-${data.aws_caller_identity.current.account_id}-logs"
  acl    = "private"

  tags = merge(
  {
    Name = "${var.bucket_name_prefix}-${data.aws_caller_identity.current.account_id}-logs"
  },
  var.tags)
}