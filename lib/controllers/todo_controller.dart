import '../models/todo_model.dart';
import '../repositories/repository.dart';

class TodoController {
  final Repository repository;

  TodoController(this.repository);

  Future<void> createTodo(Todo todo) async {
    final jsonTodo = todo.toJson();
    return await repository.createTodo(jsonTodo);
  }

  Future<void> updateTodo(Todo todo) async {
    final jsonTodo = todo.toJson();
    return await repository.updateTodo(jsonTodo, todo.id ?? '');
  }

  Future<void> deleteTodo(Todo todo) async {
    return await repository.deleteTodo(todo.id ?? '');
  }

  Future<List<Todo>> getAllTodos() async {
    return await repository.getAllTodos();
  }
}
