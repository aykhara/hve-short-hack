"""
Sample fruit price data for testing the API.

This module provides sample data for fruit prices including historical
data for testing purposes.
"""

from datetime import date, timedelta
from typing import Dict, List, TypedDict


class FruitPrice(TypedDict):
    """Type definition for a fruit price entry."""

    name: str
    price: float


class PriceData(TypedDict):
    """Type definition for daily price data."""

    date: str
    currency: str
    fruits: List[FruitPrice]


# Data validation constants
VALID_FRUIT_NAMES = {"apple", "banana", "orange", "grape", "strawberry"}
MIN_PRICE = 0.01
MAX_PRICE = 100.00
DEFAULT_CURRENCY = "USD"

# Current fruit prices (today's data)
CURRENT_PRICES: List[FruitPrice] = [
    {"name": "apple", "price": 2.99},
    {"name": "banana", "price": 1.49},
    {"name": "orange", "price": 3.49},
    {"name": "grape", "price": 4.99},
    {"name": "strawberry", "price": 5.99},
]

# Historical price data for testing
HISTORICAL_PRICES: Dict[str, List[FruitPrice]] = {
    # Yesterday's prices
    (date.today() - timedelta(days=1)).isoformat(): [
        {"name": "apple", "price": 2.89},
        {"name": "banana", "price": 1.39},
        {"name": "orange", "price": 3.39},
        {"name": "grape", "price": 4.89},
        {"name": "strawberry", "price": 5.89},
    ],
    # Two days ago
    (date.today() - timedelta(days=2)).isoformat(): [
        {"name": "apple", "price": 2.79},
        {"name": "banana", "price": 1.29},
        {"name": "orange", "price": 3.29},
        {"name": "grape", "price": 4.79},
        {"name": "strawberry", "price": 5.79},
    ],
    # Three days ago
    (date.today() - timedelta(days=3)).isoformat(): [
        {"name": "apple", "price": 2.69},
        {"name": "banana", "price": 1.19},
        {"name": "orange", "price": 3.19},
        {"name": "grape", "price": 4.69},
        {"name": "strawberry", "price": 5.69},
    ],
}


def get_prices_for_date(target_date: date) -> List[FruitPrice]:
    """
    Get fruit prices for a specific date.

    Args:
        target_date: The date to get prices for

    Returns:
        List[FruitPrice]: List of fruit prices for the specified date
    """
    date_str = target_date.isoformat()
    if date_str == date.today().isoformat():
        return CURRENT_PRICES
    return HISTORICAL_PRICES.get(date_str, CURRENT_PRICES)


def validate_price(price: float) -> bool:
    """
    Validate that a price is within acceptable range.

    Args:
        price: The price to validate

    Returns:
        bool: True if price is valid, False otherwise
    """
    return MIN_PRICE <= price <= MAX_PRICE


def validate_fruit_name(name: str) -> bool:
    """
    Validate that a fruit name is in the list of valid fruits.

    Args:
        name: The fruit name to validate

    Returns:
        bool: True if fruit name is valid, False otherwise
    """
    return name.lower() in VALID_FRUIT_NAMES
