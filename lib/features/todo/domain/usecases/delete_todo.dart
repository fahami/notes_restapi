import 'package:notes_restapi/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notes_restapi/core/usecases/usecase.dart';
import 'package:notes_restapi/features/todo/domain/repositories/todos_repository.dart';

import 'params_todo.dart';

class DeleteTodo extends UseCase<void, Params> {
  final TodoRepository repository;

  DeleteTodo(this.repository);

  @override
  Future<Either<Failure, void>> call(Params params) async {
    return await repository.deleteTodo(params.todo);
  }
}
