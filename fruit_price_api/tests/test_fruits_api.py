"""
Tests for the Fruit Prices API.

This module contains unit and integration tests for the fruits API endpoints.
"""

from datetime import date

import pytest

from src.app import create_app
from src.data.sample_prices import CURRENT_PRICES


@pytest.fixture
def client():
    """
    Create a test client for the Flask application.

    Returns:
        FlaskClient: Test client for making requests
    """
    app = create_app()
    app.config["TESTING"] = True
    with app.test_client() as client:
        yield client


class TestFruitsPricesEndpoint:
    """Test cases for the /api/fruits/prices endpoint."""

    def test_get_prices_success(self, client):
        """
        Test successful retrieval of fruit prices.

        Verifies:
        - Status code is 200
        - Response is valid JSON
        - Response contains required fields
        """
        response = client.get("/api/fruits/prices")
        assert response.status_code == 200

        data = response.get_json()
        assert data is not None
        assert "date" in data
        assert "currency" in data
        assert "fruits" in data

    def test_response_contains_all_fruits(self, client):
        """
        Test that response includes all 5 fruits.

        Verifies:
        - Response contains exactly 5 fruits
        - All expected fruit names are present
        """
        response = client.get("/api/fruits/prices")
        data = response.get_json()

        assert len(data["fruits"]) == 5

        fruit_names = {fruit["name"] for fruit in data["fruits"]}
        expected_names = {"apple", "banana", "orange", "grape", "strawberry"}
        assert fruit_names == expected_names

    def test_response_date_field(self, client):
        """
        Test that date field is present and valid.

        Verifies:
        - Date field exists
        - Date is in ISO format (YYYY-MM-DD)
        - Date is today's date
        """
        response = client.get("/api/fruits/prices")
        data = response.get_json()

        assert "date" in data
        assert data["date"] == date.today().isoformat()

    def test_response_currency_field(self, client):
        """
        Test that currency field is present and valid.

        Verifies:
        - Currency field exists
        - Currency is USD
        """
        response = client.get("/api/fruits/prices")
        data = response.get_json()

        assert "currency" in data
        assert data["currency"] == "USD"

    def test_fruit_price_structure(self, client):
        """
        Test that each fruit has correct structure.

        Verifies:
        - Each fruit has 'name' field
        - Each fruit has 'price' field
        - Price is a number
        - Price is positive
        """
        response = client.get("/api/fruits/prices")
        data = response.get_json()

        for fruit in data["fruits"]:
            assert "name" in fruit
            assert "price" in fruit
            assert isinstance(fruit["name"], str)
            assert isinstance(fruit["price"], (int, float))
            assert fruit["price"] > 0

    def test_fruit_prices_match_sample_data(self, client):
        """
        Test that returned prices match the sample data.

        Verifies:
        - Prices match expected values from CURRENT_PRICES
        """
        response = client.get("/api/fruits/prices")
        data = response.get_json()

        # Create a mapping of fruit names to prices from response
        response_prices = {fruit["name"]: fruit["price"] for fruit in data["fruits"]}

        # Verify each fruit price matches sample data
        for expected_fruit in CURRENT_PRICES:
            name = expected_fruit["name"]
            expected_price = expected_fruit["price"]
            assert name in response_prices
            assert response_prices[name] == expected_price

    def test_content_type_is_json(self, client):
        """
        Test that response content type is JSON.

        Verifies:
        - Content-Type header is application/json
        """
        response = client.get("/api/fruits/prices")
        assert response.content_type == "application/json"


class TestHealthEndpoint:
    """Test cases for the /health endpoint."""

    def test_health_check_success(self, client):
        """
        Test health check endpoint.

        Verifies:
        - Status code is 200
        - Response contains 'status' field
        - Status is 'healthy'
        """
        response = client.get("/health")
        assert response.status_code == 200

        data = response.get_json()
        assert "status" in data
        assert data["status"] == "healthy"


class TestErrorHandling:
    """Test cases for error handling."""

    def test_404_not_found(self, client):
        """
        Test 404 error handling for non-existent endpoint.

        Verifies:
        - Status code is 404
        - Response contains error_code and message
        """
        response = client.get("/api/nonexistent")
        assert response.status_code == 404

        data = response.get_json()
        assert "error_code" in data
        assert "message" in data
        assert data["error_code"] == "NOT_FOUND"
