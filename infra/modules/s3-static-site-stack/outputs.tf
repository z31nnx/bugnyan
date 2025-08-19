output "web_bucket_id" {
  value = aws_s3_bucket.web.id
}

output "web_cloudfront_logs_bucket_id" {
  value = aws_s3_bucket.web_cloudfront_logs.id
}

output "web_bucket" {
  value = aws_s3_bucket.web.bucket
}

output "web_cloudfront_logs_bucket" {
  value = aws_s3_bucket.web_cloudfront_logs.bucket
}

output "web_bucket_domain_name" {
  value = aws_s3_bucket.web.bucket_regional_domain_name
}

output "web_cloudfront_logs_bucket_domain_name" {
  value = aws_s3_bucket.web_cloudfront_logs.bucket_domain_name
}
