from typing import Iterator, List, Optional

import requests

from .schemas import Asset, DataResponse


COINBASE_API_URL_BASE = "https://www.coinbase.com/api/v2"
GET_ASSET_PATH = "/assets/info/"
GET_STATS_PATH = "/assets/stats/"
LIST_ASSETS_PATH = "/assets/search"


def get_all_listed_assets() -> Iterator[dict]:
    starting_after = None

    while True:
        response = _get_asset_page("listed", starting_after)
        yield from response.data

        if response.pagination is not None:
            starting_after = response.pagination.next_starting_after

        if starting_after is None:
            break


def _get_asset_page(asset_filter: str, starting_after: Optional[str]) -> DataResponse[List[dict]]:
    params = {
        "base": "USD",
        "filter": asset_filter,
        "include_prices": False,
        "limit": 10,
        "order": "asc",
        "query": "",
        "resolution": "day",
        "sort": "rank",
    }

    if starting_after is not None:
        params["starting_after"] = starting_after

    response = requests.get(
        f"{COINBASE_API_URL_BASE}{LIST_ASSETS_PATH}",
        params=params,
    )

    return DataResponse[List[dict]](**response.json())


def get_asset(asset_slug: str) -> Asset:
    response = requests.get(
        f"{COINBASE_API_URL_BASE}{GET_ASSET_PATH}/{asset_slug}",
    )

    return DataResponse[Asset](**response.json()).data


def get_asset_stats(asset_id: str) -> dict:
    response = requests.get(
        f"{COINBASE_API_URL_BASE}{GET_STATS_PATH}/{asset_id}",
    )

    return DataResponse[dict](**response.json()).data
