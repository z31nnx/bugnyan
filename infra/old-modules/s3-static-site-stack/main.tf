resource "aws_s3_bucket" "web" {
  bucket        = "bugnyan"
  force_destroy = true

  tags = merge(
    local.global_tags, {
      Name = var.bucket_names["web"]
    }
  )
}

resource "aws_s3_bucket_policy" "web_bucket_policy" {
  bucket = aws_s3_bucket.web.id
  policy = file("${path.module}/web-policy.json")
}

resource "aws_s3_bucket_ownership_controls" "web_bucket_ownership" {
  bucket = aws_s3_bucket.web.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_public_access_block" "web_public_access" {
  bucket = aws_s3_bucket.web.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "web_sse" {
  bucket = aws_s3_bucket.web.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "web_versioning" {
  bucket = aws_s3_bucket.web.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "web_lifecycle" {
  bucket = aws_s3_bucket.web.id

  rule {
    id     = "expire-old-versions"
    status = "Enabled"

    filter {} # Applies to all objects

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }

}

resource "aws_s3_bucket" "web_cloudfront_logs" {
  bucket        = "bugnyan-cloudfront-logs"
  force_destroy = true

  tags = merge(
    local.global_tags, {
      Name = var.bucket_names["cloudfront"]
    }
  )
}

resource "aws_s3_bucket_ownership_controls" "web_cloudfront_logs_bucket_ownership" {
  bucket = aws_s3_bucket.web_cloudfront_logs.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_public_access_block" "web_cloudfront_public_access" {
  bucket = aws_s3_bucket.web_cloudfront_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "web_cloudfront_sse" {
  bucket = aws_s3_bucket.web_cloudfront_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "web_cloudfront_versioning" {
  bucket = aws_s3_bucket.web_cloudfront_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "web_cloudfront_lifecycle" {
  bucket = aws_s3_bucket.web_cloudfront_logs.id

  rule {
    id     = "expire-old-versions"
    status = "Enabled"

    filter {} # Applies to all objects

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }

}
