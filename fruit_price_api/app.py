"""Flask application factory and configuration."""

import logging
from typing import Any

from flask import Flask
from werkzeug.exceptions import HTTPException

from src.api.routes import api_bp
from src.utils.error_handler import (
    APIError,
    handle_api_error,
    handle_general_exception,
    handle_http_exception,
)


def create_app() -> Flask:
    """
    Create and configure the Flask application.

    Returns:
        Configured Flask application instance.
    """
    app = Flask(__name__)

    # Configure logging
    logging.basicConfig(
        level=logging.INFO,
        format="%(asctime)s - %(name)s - %(levelname)s - %(message)s",
    )

    # Register blueprints
    app.register_blueprint(api_bp)

    # Register error handlers
    app.register_error_handler(APIError, handle_api_error)
    app.register_error_handler(HTTPException, handle_http_exception)
    app.register_error_handler(Exception, handle_general_exception)

    app.logger.info("Fruit Price API initialized successfully")

    return app


if __name__ == "__main__":
    app = create_app()
    app.run(debug=True, host="0.0.0.0", port=5000)
