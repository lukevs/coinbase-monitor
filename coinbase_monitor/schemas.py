from datetime import datetime
from typing import Generic, Optional, TypeVar

from pydantic import BaseModel
from pydantic.generics import GenericModel


DataT = TypeVar('DataT')


class PaginationResponse(BaseModel):
    next_starting_after: Optional[str]


class DataResponse(GenericModel, Generic[DataT]):
    data: DataT
    pagination: Optional[PaginationResponse]


class Asset(BaseModel):
    id: str
    name: str
