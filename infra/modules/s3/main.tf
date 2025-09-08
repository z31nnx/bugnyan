resource "aws_s3_bucket" "web" {
  bucket        = "${var.name_prefix}-${var.bucket_names["web"]}"
  force_destroy = true # default is false
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
# CLoudFront

resource "aws_s3_bucket" "cloudfront_logs" {
  bucket        = "${var.name_prefix}-${var.bucket_names["cloudfront"]}"
  force_destroy = true
}

resource "aws_s3_bucket_ownership_controls" "cloudfront_logs_bucket_ownership" {
  bucket = aws_s3_bucket.cloudfront_logs.id

  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}


resource "aws_s3_bucket_public_access_block" "cloudfront_public_access" {
  bucket = aws_s3_bucket.cloudfront_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_server_side_encryption_configuration" "cloudfront_sse" {
  bucket = aws_s3_bucket.cloudfront_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_versioning" "cloudfront_versioning" {
  bucket = aws_s3_bucket.cloudfront_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_lifecycle_configuration" "cloudfront_lifecycle" {
  bucket = aws_s3_bucket.cloudfront_logs.id

  rule {
    id     = "expire-old-versions"
    status = "Enabled"

    filter {} # Applies to all objects

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }

}
