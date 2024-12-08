import pytest
from app import app, todo_list


@pytest.fixture
def client():
    """Fixture for creating a test client."""
    app.testing = True
    with app.test_client() as client:
        yield client


def test_should_return_empty_list(client):
    """Test GET /todos with an empty list."""
    todo_list.clear()
    response = client.get("/todos")
    assert response.status_code == 200
    assert response.get_json() == []


def test_should_add_new_todo_successfully(client):
    """Test POST /todos with valid data."""
    todo_list.clear()
    response = client.post("/todos", json={"task": "Buy groceries"})
    assert response.status_code == 201
    data = response.get_json()
    assert data["task"] == "Buy groceries"
    assert data["done"] is False
    assert "id" in data


def test_should_fail_to_add_todo_without_task(client):
    """Test POST /todos with invalid data (missing 'task')."""
    response = client.post("/todos", json={})
    assert response.status_code == 400
    assert response.get_json() == {"error": "Task is required"}


def test_should_mark_todo_done(client):
    """Test PATCH /todos/<todo_id> to mark a todo as done."""
    todo_list.clear()
    client.post("/todos", json={"task": "Buy groceries"})
    response = client.patch("/todos/1")
    assert response.status_code == 200
    data = response.get_json()
    assert data["done"] is True


def test_should_return_404_for_invalid_todo_id(client):
    """Test PATCH /todos/<todo_id> for a non-existent ID."""
    todo_list.clear()
    response = client.patch("/todos/999")
    assert response.status_code == 404
    assert response.get_json() == {"error": "Todo not found"}


def test_should_reset_todos(client):
    """Test POST /reset to clear the todo list."""
    todo_list.clear()
    client.post("/todos", json={"task": "Buy groceries"})
    response = client.post("/reset")
    assert response.status_code == 200
    assert response.get_json() == {"message": "Reset successful"}
    assert todo_list == []
