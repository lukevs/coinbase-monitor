import json
from typing import List

import boto3


STATS_STREAM_NAME = "coinbase-monitor-stats-stream"

# firehose_client = boto3.client(
#     "firehose", endpoint_url="http://localstack:4566",
# )
firehose_client = boto3.client(
    "firehose",
)


def write_stats(stats: List[dict]) -> None:
    records = [
        {"Data": json.dumps(stats_record)}
        for stats_record in stats
    ]

    response = firehose_client.put_record_batch(
        DeliveryStreamName=STATS_STREAM_NAME,
        Records=records,
    )

    if response["FailedPutCount"] > 0:
        raise RuntimeError(f"Failed to write stats: {response}")
