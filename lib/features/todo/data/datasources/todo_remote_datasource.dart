import 'package:dio/dio.dart';
import 'package:notes_restapi/features/todo/data/model/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodos(int userId);
  Future<TodoModel> getTodoById(int id);
  Future<void> addTodo(TodoModel todo);
  Future<void> deleteTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteAllTodos();
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final Dio http;

  TodoRemoteDataSourceImpl(this.http);

  @override
  Future<void> addTodo(TodoModel todo) async {
    await http.post('/todo', data: todo.toJson());
  }

  @override
  Future<void> deleteAllTodos() async {
    await http.delete('/todo');
  }

  @override
  Future<void> deleteTodo(TodoModel todo) async {
    await http.delete('/todo/${todo.id}');
  }

  @override
  Future<TodoModel> getTodoById(int id) async {
    return await http
        .get('/todo/$id')
        .then((res) => TodoModel.fromJson(res.data));
  }

  @override
  Future<List<TodoModel>> getTodos(int userid) async {
    return await http
        .get('/todo')
        .then((res) => res.data.map((e) => TodoModel.fromJson(e)).toList());
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    await http.put('/todo/${todo.id}', data: todo.toJson());
  }
}
