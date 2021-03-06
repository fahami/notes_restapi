import 'package:notes_restapi/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notes_restapi/core/usecases/usecase.dart';
import 'package:notes_restapi/features/todo/domain/entities/todo.dart';
import 'package:notes_restapi/features/todo/domain/repositories/todos_repository.dart';

class GetTodoById extends UseCase<Todo, int> {
  final TodoRepository repository;

  GetTodoById(this.repository);

  @override
  Future<Either<Failure, Todo>> call(int params) {
    return repository.getTodoById(params);
  }
}
