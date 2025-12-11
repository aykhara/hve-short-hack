"""
Price service for managing fruit price data.

This module provides the business logic for retrieving current and
historical fruit prices.
"""

import logging
from datetime import date

from src.data.sample_prices import (
    CURRENT_PRICES,
    DEFAULT_CURRENCY,
    PriceData,
    get_prices_for_date,
)

logger = logging.getLogger(__name__)


class PriceService:
    """Service class for managing fruit price operations."""

    def __init__(self) -> None:
        """Initialize the PriceService."""
        self.currency = DEFAULT_CURRENCY
        logger.info("PriceService initialized")

    def get_current_prices(self) -> PriceData:
        """
        Get current fruit prices for today.

        Returns:
            PriceData: Dictionary containing date, currency, and fruit prices
        """
        today = date.today()
        logger.info(f"Fetching current prices for {today.isoformat()}")

        price_data: PriceData = {
            "date": today.isoformat(),
            "currency": self.currency,
            "fruits": CURRENT_PRICES.copy(),
        }

        logger.info(
            f"Retrieved {len(price_data['fruits'])} fruit prices "
            f"for {today.isoformat()}"
        )
        return price_data

    def get_prices_by_date(self, target_date: date) -> PriceData:
        """
        Get fruit prices for a specific date.

        Args:
            target_date: The date to get prices for

        Returns:
            PriceData: Dictionary containing date, currency, and fruit prices
        """
        logger.info(f"Fetching prices for {target_date.isoformat()}")

        fruits = get_prices_for_date(target_date)

        price_data: PriceData = {
            "date": target_date.isoformat(),
            "currency": self.currency,
            "fruits": fruits.copy(),
        }

        logger.info(
            f"Retrieved {len(price_data['fruits'])} fruit prices "
            f"for {target_date.isoformat()}"
        )
        return price_data

    def get_fruit_count(self) -> int:
        """
        Get the total number of fruits available.

        Returns:
            int: Number of fruits in the price list
        """
        return len(CURRENT_PRICES)
