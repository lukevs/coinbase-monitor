from coinbase_monitor.firehose.crud import write_stats
from coinbase_monitor.coinbase.crud import (
    get_all_listed_assets, get_asset_stats
)


def handler(event, context):
    all_stats = []

    for i, asset in enumerate(get_all_listed_assets()):
        stats = get_asset_stats(asset["id"])
        all_stats.append(stats)

        # TODO - remove
        break

    write_stats(all_stats)
