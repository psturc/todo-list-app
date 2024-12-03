from flask import Flask, jsonify, request

app = Flask(__name__)

todo_list = []


@app.route("/todos", methods=["GET"])
def get_todos():
    return jsonify(todo_list)


@app.route("/todos", methods=["POST"])
def add_todo():
    data = request.get_json()
    if "task" not in data:
        return jsonify({"error": "Task is required"}), 400
    todo = {"id": len(todo_list) + 1, "task": data["task"], "done": False}
    todo_list.append(todo)
    print("hello world")
    return jsonify(todo), 201


@app.route("/todos/<int:todo_id>", methods=["PATCH"])
def mark_done(todo_id):
    for todo in todo_list:
        if todo["id"] == todo_id:
            todo["done"] = True
            return jsonify(todo)
    return jsonify({"error": "Todo not found"}), 404


@app.route("/reset", methods=["POST"])
def reset():
    """Reset the todo_list for testing."""
    todo_list.clear()
    return jsonify({"message": "Reset successful"}), 200


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
