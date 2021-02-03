from coinbase_monitor.crud import get_asset, get_asset_stats


def main():
    asset_id = get_asset("bitcoin").id
    print(get_asset_stats(asset_id))


if __name__ == "__main__":
    main()
