terraform {
  backend "local" {}
}

provider "aws" {
  access_key                  = "mock_access_key"
  region                      = "us-east-1"
  s3_force_path_style         = true
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true

  endpoints {
    s3     = "http://localhost:4566"
    iam    = "http://localhost:4566"
  }
}

resource "aws_s3_bucket" "coinbase_monitor_stats_bucket" {
  bucket = "coinbase-monitor-stats-${var.environment}"
  acl    = "private"
}

resource "aws_iam_role" "coinbase_firehose_role" {
  name = "coinbase_filehose_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_kinesis_firehose_delivery_stream" "coinbase_monitor_stats_stream" {
  name        = "coinbase-monitor-stats-stream"
  destination = "s3"

  s3_configuration {
    role_arn   = aws_iam_role.coinbase_firehose_role.arn
    bucket_arn = aws_s3_bucket.coinbase_monitor_stats_bucket.arn
  }
}
