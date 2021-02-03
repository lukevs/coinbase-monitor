from coinbase_monitor.crud import get_all_listed_assets, get_asset_stats


def main():
    limit = 11

    for i, asset in enumerate(get_all_listed_assets()):
        if i >= limit:
            break

        print(asset.name)
        print(get_asset_stats(asset.id))


if __name__ == "__main__":
    main()
