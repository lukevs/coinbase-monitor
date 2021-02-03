from datetime import datetime
from typing import Generic, TypeVar

import requests
from pydantic import BaseModel
from pydantic.generics import GenericModel


COINBASE_API_URL_BASE = "https://www.coinbase.com/api/v2"
GET_ASSET_PATH = "/assets/info/"
GET_STATS_PATH = "/assets/stats/"

DataT = TypeVar('DataT')


class DataResponse(GenericModel, Generic[DataT]):
    data: DataT


class Asset(BaseModel):
    id: str


class AssetTractingActivitySignal(BaseModel):
    updated_at: datetime
    value: float


class AssetSignals(BaseModel):
    trading_activity: AssetTractingActivitySignal


class AssetStats(BaseModel):
    signals: AssetSignals


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


def main():
    asset_id = get_asset("bitcoin").id
    print(get_asset_stats(asset_id))


if __name__ == "__main__":
    main()
