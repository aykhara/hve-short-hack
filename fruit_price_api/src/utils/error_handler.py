"""Error handling utilities and custom exceptions."""

import logging
from typing import Tuple

from flask import jsonify
from werkzeug.exceptions import HTTPException

from src.models.fruit import ErrorResponse

logger = logging.getLogger(__name__)


class APIError(Exception):
    """Base exception for API errors."""

    def __init__(self, message: str, status_code: int, error_code: str) -> None:
        """
        Initialize API error.

        Args:
            message: Human-readable error message.
            status_code: HTTP status code.
            error_code: Error code identifier.
        """
        super().__init__(message)
        self.message = message
        self.status_code = status_code
        self.error_code = error_code


class BadRequestError(APIError):
    """Exception for 400 Bad Request errors."""

    def __init__(self, message: str = "Bad request") -> None:
        """
        Initialize bad request error.

        Args:
            message: Human-readable error message.
        """
        super().__init__(message=message, status_code=400, error_code="BAD_REQUEST")


class NotFoundError(APIError):
    """Exception for 404 Not Found errors."""

    def __init__(self, message: str = "Resource not found") -> None:
        """
        Initialize not found error.

        Args:
            message: Human-readable error message.
        """
        super().__init__(message=message, status_code=404, error_code="NOT_FOUND")


def handle_api_error(error: APIError) -> Tuple[dict, int]:
    """
    Handle custom API errors.

    Args:
        error: The API error to handle.

    Returns:
        Tuple of (response dict, status code).
    """
    logger.warning(f"API Error: {error.error_code} - {error.message}")

    error_response = ErrorResponse(error_code=error.error_code, message=error.message)

    return error_response.model_dump(), error.status_code


def handle_http_exception(error: HTTPException) -> Tuple[dict, int]:
    """
    Handle Flask HTTP exceptions.

    Args:
        error: The HTTP exception to handle.

    Returns:
        Tuple of (response dict, status code).
    """
    logger.warning(f"HTTP Exception: {error.code} - {error.description}")

    error_code = "HTTP_ERROR"
    if error.code == 400:
        error_code = "BAD_REQUEST"
    elif error.code == 404:
        error_code = "NOT_FOUND"

    error_response = ErrorResponse(
        error_code=error_code, message=error.description or "An error occurred"
    )

    return error_response.model_dump(), error.code or 500


def handle_general_exception(error: Exception) -> Tuple[dict, int]:
    """
    Handle unexpected exceptions.

    Args:
        error: The exception to handle.

    Returns:
        Tuple of (response dict, status code).
    """
    logger.error(f"Unexpected error: {str(error)}", exc_info=True)

    error_response = ErrorResponse(
        error_code="INTERNAL_ERROR", message="An internal error occurred"
    )

    return error_response.model_dump(), 500
