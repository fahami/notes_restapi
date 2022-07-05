import 'package:dartz/dartz.dart';
import 'package:notes_restapi/core/error/failures.dart';
import 'package:notes_restapi/core/usecases/usecase.dart';
import 'package:notes_restapi/features/todo/domain/entities/color.dart';
import 'package:notes_restapi/features/todo/domain/repositories/colors_repository.dart';

class GetTodoColor extends UseCase<List<TodoColor>, NoParams> {
  final TodoColorsRepository repository;

  GetTodoColor(this.repository);

  @override
  Future<Either<Failure, List<TodoColor>>> call(NoParams params) {
    return repository.getColors();
  }
}
