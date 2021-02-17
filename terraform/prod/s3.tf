resource "aws_s3_bucket" "coinbase_monitor_stats" {
  bucket = "coinbase-monitor-stats-${var.environment}"
  acl    = "private"
}
