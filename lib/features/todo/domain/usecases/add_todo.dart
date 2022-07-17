import 'package:notes_restapi/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notes_restapi/core/usecases/usecase.dart';
import 'package:notes_restapi/features/todo/domain/repositories/todos_repository.dart';

import 'params_todo.dart';

class AddTodo extends UseCase<void, Params> {
  final TodoRepository repository;

  AddTodo(this.repository);
  @override
  Future<Either<Failure, void>> call(Params params) async {
    return repository.addTodo(params.todo);
  }
}
