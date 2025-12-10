"""API routes for fruit pricing endpoints."""

import logging
from typing import Any, Dict

from flask import Blueprint, jsonify

from src.models.fruit import PriceResponse
from src.services.price_service import get_daily_prices
from src.utils.error_handler import NotFoundError

logger = logging.getLogger(__name__)

api_bp = Blueprint("api", __name__, url_prefix="/api")


@api_bp.route("/fruits/prices", methods=["GET"])
def get_fruit_prices() -> tuple[Dict[str, Any], int]:
    """
    Get daily fruit prices.

    Returns:
        JSON response with fruit prices and HTTP status code 200.

    Raises:
        NotFoundError: If price data cannot be retrieved.
    """
    logger.info("GET /api/fruits/prices - Request received")

    try:
        price_response = get_daily_prices()
        response_data = price_response.model_dump()

        logger.info(
            f"GET /api/fruits/prices - Success: {len(price_response.fruits)} fruits"
        )

        return response_data, 200

    except FileNotFoundError as e:
        logger.error(f"Price data not found: {e}")
        raise NotFoundError("Price data is currently unavailable") from e
    except ValueError as e:
        logger.error(f"Invalid price data: {e}")
        raise NotFoundError("Price data is corrupted") from e
