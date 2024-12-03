import pytest
from app import app, todo_list


@pytest.fixture
def client():
    app.testing = True
    with app.test_client() as client:
        yield client


def test_should_return_empty_list(client):
    todo_list.clear()
    response = client.get("/todos")
    assert response.status_code == 200
    assert response.get_json() == []


def test_should_add_new_todo(client):
    todo_list.clear()
    response = client.post("/todos", json={"task": "Buy groceries"})
    assert response.status_code == 201
    assert "Buy groceries" in str(response.get_json())
