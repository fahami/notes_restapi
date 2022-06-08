import 'package:notes_restapi/core/error/exception.dart';
import 'package:notes_restapi/core/network/network_info.dart';
import 'package:notes_restapi/features/todo/data/datasources/todo_local_datasource.dart';
import 'package:notes_restapi/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:notes_restapi/features/todo/data/model/todo_model.dart';
import 'package:notes_restapi/features/todo/domain/entities/todo.dart';
import 'package:notes_restapi/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notes_restapi/features/todo/domain/repositories/todos_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;
  final TodoRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TodoRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, void>> addTodo(TodoModel todo) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.addTodo(todo);
        localDataSource.cacheTodo(todo);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        localDataSource.cacheTodo(todo);
        return const Right(null);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllTodos() async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteAllTodos();
        localDataSource.deleteAllTodos();
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        localDataSource.deleteAllTodos();
        return const Right(null);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(TodoModel todo) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.deleteTodo(todo);
        localDataSource.deleteTodo(todo);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        localDataSource.deleteTodo(todo);
        return const Right(null);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    if (await networkInfo.isConnected) {
      try {
        final todos = await remoteDataSource.getTodos();
        for (var todo in todos) {
          localDataSource.cacheTodo(todo);
        }
        return Right(todos);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final todos = localDataSource.getTodos();
        return Right(todos);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, void>> updateTodo(TodoModel todo) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.updateTodo(todo);
        localDataSource.updateTodo(todo);
        return const Right(null);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        localDataSource.cacheTodo(todo);
        return const Right(null);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Todo>> getTodoById(String id) async {
    if (await networkInfo.isConnected) {
      try {
        final todo = await remoteDataSource.getTodoById(id);
        localDataSource.cacheTodo(todo);
        return Right(todo);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final todo = localDataSource.getTodoById(id);
        return Right(todo);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
