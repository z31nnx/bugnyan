data "aws_caller_identity" "current" {}
data "aws_partition" "current" {}
data "aws_region" "current" {}

locals {
  account_id   = data.aws_caller_identity.current.account_id
  partition    = data.aws_partition.current.partition
  region       = data.aws_region.current.name
  distribution = aws_cloudfront_distribution.web_distribution.id
}

data "aws_iam_policy_document" "web_bucket_policy" {
  statement {
    sid     = "PolicyForCloudFrontPrivateContent"
    effect  = "Allow"
    actions = ["s3:GetObject"]
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    resources = ["${var.bucket_arns}/*"]
    condition {
      test     = "StringEquals"
      variable = "aws:SourceArn"
      values   = ["arn:${local.partition}:cloudfront::${local.account_id}:distribution/${local.distribution}"]
    }
  }
}

resource "aws_s3_bucket_policy" "web" {
  bucket = var.bucket_names
  policy = data.aws_iam_policy_document.web_bucket_policy.json
}
