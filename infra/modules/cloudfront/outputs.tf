output "distributions" {
  value = {
    web = aws_cloudfront_distribution.web_distribution.id, sensitive = true
  }
  sensitive = true
}
