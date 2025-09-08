output "bucket_names" {
  value = {
    web        = aws_s3_bucket.web.bucket
    cloudfront = aws_s3_bucket.cloudfront_logs.bucket
  }
}

output "bucket_arns" {
  value = {
    web        = aws_s3_bucket.web.arn
    cloudfront = aws_s3_bucket.cloudfront_logs.arn
  }
}

output "bucket_domain_names" {
  value = {
    web        = aws_s3_bucket.web.bucket_domain_name
    cloudfront = aws_s3_bucket.cloudfront_logs.bucket_domain_name
  }

}

output "bucket_regional_domain_names" {
  value = {
    web        = aws_s3_bucket.web.bucket_regional_domain_name
    cloudfront = aws_s3_bucket.cloudfront_logs.bucket_regional_domain_name
  }
}
