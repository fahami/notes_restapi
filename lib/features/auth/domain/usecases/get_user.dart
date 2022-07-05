import 'package:dartz/dartz.dart';
import 'package:notes_restapi/core/error/failures.dart';
import 'package:notes_restapi/core/usecases/usecase.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';
import 'package:notes_restapi/features/auth/domain/repositories/auth_repository.dart';

class GetUserUseCase extends UseCase<User, NoParams> {
  final AuthRepository repository;

  GetUserUseCase(this.repository);
  @override
  Future<Either<Failure, User>> call(NoParams params) {
    return repository.getUser();
  }
}
