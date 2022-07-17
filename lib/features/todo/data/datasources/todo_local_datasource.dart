import 'package:hive/hive.dart';
import 'package:notes_restapi/core/error/exception.dart';
import 'package:notes_restapi/features/todo/data/model/todo_model.dart';
import 'package:notes_restapi/features/todo/domain/entities/todo.dart';

abstract class TodoLocalDataSource {
  List<TodoModel> getTodos();
  TodoModel getTodoById(int id);
  Future<void> cacheTodo(TodoModel todoToCache);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteTodo(TodoModel todo);
  Future<void> deleteAllTodos();
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final Box<Todo> todoBox;

  TodoLocalDataSourceImpl(this.todoBox);

  @override
  Future<void> cacheTodo(TodoModel todoToCache) {
    return todoBox.put(todoToCache.id, todoToCache);
  }

  @override
  List<TodoModel> getTodos() {
    final todos = todoBox.values.toList();
    if (todos.isNotEmpty) {
      return todos as List<TodoModel>;
    } else {
      throw CacheException('No todos found');
    }
  }

  @override
  TodoModel getTodoById(int id) {
    final todo = todoBox.get(id);
    if (todo != null) {
      return todo as TodoModel;
    } else {
      throw CacheException('No todo found');
    }
  }

  @override
  Future<void> deleteAllTodos() async {
    await todoBox.clear();
  }

  @override
  Future<void> deleteTodo(TodoModel todo) {
    return todoBox.delete(todo.id);
  }

  @override
  Future<void> updateTodo(TodoModel todo) {
    return todoBox.put(todo.id, todo);
  }
}
