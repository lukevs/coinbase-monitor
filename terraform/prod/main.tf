terraform {
  backend "local" {}
}

provider "aws" {
  region                      = "us-east-1"
}

resource "aws_s3_bucket" "coinbase_monitor_stats_bucket" {
  bucket = "coinbase-monitor-stats-${var.environment}"
  acl    = "private"
}

resource "aws_iam_role" "coinbase_firehose_role" {
  name = "coinbase_filehose_role"

  assume_role_policy = jsonencode({
      Version = "2012-10-17"
      Statement = [
        {
          Action = "sts:AssumeRole"
          Effect = "Allow"
          Sid    = ""
          Principal = {
            Service = "firehose.amazonaws.com"
          }
        }
      ]
    })
}

resource "aws_iam_role_policy" "coinbase_firehose_role_s3_policy" {
  name = "coinbase_firehose_role_s3_policy"
  role = aws_iam_role.coinbase_firehose_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:AbortMultipartUpload",
          "s3:GetBucketLocation",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:ListBucketMultipartUploads",
          "s3:PutObject"
        ]
        Effect = "Allow"
        Sid    = ""
        Resource = [
            "${aws_s3_bucket.coinbase_monitor_stats_bucket.arn}",
            "${aws_s3_bucket.coinbase_monitor_stats_bucket.arn}/*"
        ]
      },
    ]
  })
}

resource "aws_kinesis_firehose_delivery_stream" "coinbase_monitor_stats_stream" {
  name        = "coinbase-monitor-stats-stream"
  destination = "s3"

  s3_configuration {
    role_arn   = aws_iam_role.coinbase_firehose_role.arn
    bucket_arn = aws_s3_bucket.coinbase_monitor_stats_bucket.arn
  }
}
