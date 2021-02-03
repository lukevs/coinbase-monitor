from datetime import datetime
from typing import Generic, TypeVar

from pydantic import BaseModel
from pydantic.generics import GenericModel


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
