from coinbase_monitor.crud import get_all_listed_assets, get_asset_stats


def handler(event, context):
    for i, asset in enumerate(get_all_listed_assets()):
        stats = get_asset_stats(asset.id)
        print(asset)
        print(stats)
        print()
