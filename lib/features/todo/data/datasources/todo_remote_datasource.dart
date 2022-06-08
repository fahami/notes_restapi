import 'package:dio/dio.dart';
import 'package:notes_restapi/core/error/exception.dart';
import 'package:notes_restapi/features/todo/data/model/todo_model.dart';

abstract class TodoRemoteDataSource {
  Future<List<TodoModel>> getTodos();
  Future<TodoModel> getTodoById(String id);
  Future<void> addTodo(TodoModel todo);
  Future<void> deleteTodo(TodoModel todo);
  Future<void> updateTodo(TodoModel todo);
  Future<void> deleteAllTodos();
}

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  final Dio fireStore;

  TodoRemoteDataSourceImpl(this.fireStore);

  @override
  Future<void> addTodo(TodoModel todo) {
    // TODO: implement addTodo
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAllTodos() {
    // TODO: implement deleteAllTodos
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTodo(TodoModel todo) {
    // TODO: implement deleteTodo
    throw UnimplementedError();
  }

  @override
  Future<TodoModel> getTodoById(String id) {
    // TODO: implement getTodoById
    throw UnimplementedError();
  }

  @override
  Future<List<TodoModel>> getTodos() {
    // TODO: implement getTodos
    throw UnimplementedError();
  }

  @override
  Future<void> updateTodo(TodoModel todo) {
    // TODO: implement updateTodo
    throw UnimplementedError();
  }
}
