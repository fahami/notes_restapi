import 'package:notes_restapi/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notes_restapi/core/usecases/usecase.dart';
import 'package:notes_restapi/features/auth/domain/usecases/params_user.dart';
import 'package:notes_restapi/features/todo/domain/entities/todo.dart';
import 'package:notes_restapi/features/todo/domain/repositories/todos_repository.dart';

class GetTodos extends UseCase<List<Todo>, ParamsUser> {
  final TodoRepository repository;

  GetTodos(this.repository);

  @override
  Future<Either<Failure, List<Todo>>> call(ParamsUser params) async {
    return repository.getTodos(params.user.id);
  }
}
