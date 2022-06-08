import 'package:notes_restapi/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notes_restapi/core/usecases/usecase.dart';
import 'package:notes_restapi/features/todo/domain/repositories/todos_repository.dart';

class DeleteAllTodo extends UseCase<void, NoParams> {
  final TodoRepository repository;

  DeleteAllTodo(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.deleteAllTodos();
  }
}
