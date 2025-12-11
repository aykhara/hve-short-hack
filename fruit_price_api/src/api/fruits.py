"""
Fruits API blueprint.

This module defines the API endpoints for fruit price operations.
"""

import logging
from typing import Any

from flask import Blueprint, Response, jsonify

from src.services.price_service import PriceService

logger = logging.getLogger(__name__)

# Create blueprint
fruits_bp = Blueprint("fruits", __name__, url_prefix="/api/fruits")

# Initialize price service
price_service = PriceService()


@fruits_bp.route("/prices", methods=["GET"])
def get_prices() -> Response:
    """
    Get current fruit prices.

    Returns:
        Response: JSON response with date, currency, and fruit prices

    Response format:
        {
            "date": "2025-12-11",
            "currency": "USD",
            "fruits": [
                {"name": "apple", "price": 2.99},
                ...
            ]
        }
    """
    logger.info("GET /api/fruits/prices - Request received")

    try:
        # Get current prices from service
        price_data = price_service.get_current_prices()

        logger.info(
            f"GET /api/fruits/prices - Returning {len(price_data['fruits'])} fruits"
        )
        return jsonify(price_data)

    except Exception as e:
        logger.error(f"GET /api/fruits/prices - Error: {str(e)}")
        raise
