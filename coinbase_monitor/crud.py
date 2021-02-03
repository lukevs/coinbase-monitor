import requests

from .schemas import Asset, AssetStats, DataResponse


COINBASE_API_URL_BASE = "https://www.coinbase.com/api/v2"
GET_ASSET_PATH = "/assets/info/"
GET_STATS_PATH = "/assets/stats/"


def get_asset(asset_slug: str) -> Asset:
    response = requests.get(
        f"{COINBASE_API_URL_BASE}{GET_ASSET_PATH}/{asset_slug}",
    )

    return DataResponse[Asset](**response.json()).data


def get_asset_stats(asset_id: str) -> AssetStats:
    response = requests.get(
        f"{COINBASE_API_URL_BASE}{GET_STATS_PATH}/{asset_id}",
    )

    return DataResponse[AssetStats](**response.json()).data
