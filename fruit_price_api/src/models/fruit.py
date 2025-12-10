"""Data models for fruit pricing."""

from datetime import date
from typing import List

from pydantic import BaseModel, Field


class Fruit(BaseModel):
    """Model representing a fruit with its price."""

    name: str = Field(..., description="Name of the fruit")
    price: float = Field(..., gt=0, description="Price of the fruit in USD")


class PriceResponse(BaseModel):
    """Model for the API response containing fruit prices."""

    date: str = Field(..., description="Date of the price data (YYYY-MM-DD)")
    currency: str = Field(default="USD", description="Currency code")
    fruits: List[Fruit] = Field(..., description="List of fruits with prices")


class ErrorResponse(BaseModel):
    """Model for error responses."""

    error_code: str = Field(..., description="Error code identifier")
    message: str = Field(..., description="Human-readable error message")
