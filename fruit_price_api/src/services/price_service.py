"""Service for retrieving fruit price data."""

import json
import logging
from datetime import date
from pathlib import Path
from typing import Dict, Any

from src.models.fruit import Fruit, PriceResponse

logger = logging.getLogger(__name__)


def get_daily_prices() -> PriceResponse:
    """
    Retrieve daily fruit prices from the data file.

    Returns:
        PriceResponse: Response containing current date, currency, and fruit prices.

    Raises:
        FileNotFoundError: If the prices data file cannot be found.
        ValueError: If the data file contains invalid data.
    """
    data_file = Path(__file__).parent.parent / "data" / "prices.json"

    logger.info(f"Loading price data from {data_file}")

    try:
        with open(data_file, "r", encoding="utf-8") as f:
            data: Dict[str, Any] = json.load(f)
    except FileNotFoundError as e:
        logger.error(f"Price data file not found: {data_file}")
        raise FileNotFoundError(f"Price data file not found: {data_file}") from e
    except json.JSONDecodeError as e:
        logger.error(f"Invalid JSON in price data file: {e}")
        raise ValueError(f"Invalid JSON in price data file: {e}") from e

    try:
        fruits = [Fruit(**fruit_data) for fruit_data in data["fruits"]]
    except (KeyError, TypeError) as e:
        logger.error(f"Invalid data structure in price file: {e}")
        raise ValueError(f"Invalid data structure in price file: {e}") from e

    today = date.today().isoformat()

    response = PriceResponse(date=today, currency="USD", fruits=fruits)

    logger.info(f"Successfully loaded {len(fruits)} fruit prices for {today}")

    return response
