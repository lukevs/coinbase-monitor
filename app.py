from coinbase_monitor.crud import get_all_listed_assets, get_asset_stats


def main():
    for i, asset in enumerate(get_all_listed_assets()):
        stats = get_asset_stats(asset.id)
        print(asset)
        print(stats)
        print()


if __name__ == "__main__":
    main()
