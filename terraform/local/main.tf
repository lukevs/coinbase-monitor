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
    apigateway     = "http://localhost:4566"
    cloudformation = "http://localhost:4566"
    cloudwatch     = "http://localhost:4566"
    dynamodb       = "http://localhost:4566"
    ec2            = "http://localhost:4566"
    es             = "http://localhost:4566"
    elasticache    = "http://localhost:4566"
    firehose       = "http://localhost:4566"
    iam            = "http://localhost:4566"
    kinesis        = "http://localhost:4566"
    lambda         = "http://localhost:4566"
    rds            = "http://localhost:4566"
    redshift       = "http://localhost:4566"
    route53        = "http://localhost:4566"
    s3             = "http://localhost:4566"
    secretsmanager = "http://localhost:4566"
    ses            = "http://localhost:4566"
    sns            = "http://localhost:4566"
    sqs            = "http://localhost:4566"
    ssm            = "http://localhost:4566"
    stepfunctions  = "http://localhost:4566"
    sts            = "http://localhost:4566"
  }
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
