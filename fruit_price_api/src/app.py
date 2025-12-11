"""
Flask application entry point for the Fruit Price API.

This module initializes the Flask application with proper configuration,
error handling, logging, and CORS support.
"""

import logging
from typing import Any, Dict, Tuple

from flask import Flask, Response, jsonify
from flask_cors import CORS


def create_app() -> Flask:
    """
    Create and configure the Flask application.

    Returns:
        Flask: Configured Flask application instance
    """
    app = Flask(__name__)

    # Configure logging
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    )
    app.logger.setLevel(logging.INFO)

    # Configure CORS
    CORS(app)

    # Register error handlers
    register_error_handlers(app)

    # Register blueprints
    from src.api.fruits import fruits_bp

    app.register_blueprint(fruits_bp)

    # Health check endpoint
    @app.route("/health", methods=["GET"])
    def health_check() -> Dict[str, str]:
        """
        Health check endpoint.

        Returns:
            Dict[str, str]: Health status response
        """
        app.logger.info("Health check requested")
        return {"status": "healthy"}

    app.logger.info("Flask application initialized successfully")
    return app


def register_error_handlers(app: Flask) -> None:
    """
    Register custom error handlers for the application.

    Args:
        app: Flask application instance
    """

    @app.errorhandler(400)
    def bad_request(error: Any) -> Tuple[Response, int]:
        """
        Handle 400 Bad Request errors.

        Args:
            error: Error object

        Returns:
            Tuple[Response, int]: Error response and status code
        """
        app.logger.error(f"Bad request: {error}")
        return jsonify({"error_code": "BAD_REQUEST", "message": str(error)}), 400

    @app.errorhandler(404)
    def not_found(error: Any) -> Tuple[Response, int]:
        """
        Handle 404 Not Found errors.

        Args:
            error: Error object

        Returns:
            Tuple[Response, int]: Error response and status code
        """
        app.logger.error(f"Resource not found: {error}")
        return jsonify({"error_code": "NOT_FOUND", "message": str(error)}), 404

    @app.errorhandler(500)
    def internal_error(error: Any) -> Tuple[Response, int]:
        """
        Handle 500 Internal Server Error.

        Args:
            error: Error object

        Returns:
            Tuple[Response, int]: Error response and status code
        """
        app.logger.error(f"Internal server error: {error}")
        return (
            jsonify(
                {
                    "error_code": "INTERNAL_SERVER_ERROR",
                    "message": "An internal error occurred",
                }
            ),
            500,
        )


if __name__ == "__main__":
    app = create_app()
    app.run(debug=True, host="0.0.0.0", port=5000)
