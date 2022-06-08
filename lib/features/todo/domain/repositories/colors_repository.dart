import 'package:dartz/dartz.dart';
import 'package:notes_restapi/core/error/failures.dart';
import 'package:notes_restapi/features/todo/domain/entities/color.dart';

abstract class TodoColorsRepository {
  Future<Either<Failure, List<TodoColor>>> getColors();
}
