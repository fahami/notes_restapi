import 'package:dartz/dartz.dart';
import 'package:notes_restapi/core/error/failures.dart';
import 'package:notes_restapi/core/usecases/usecase.dart';
import 'package:notes_restapi/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase extends UseCase<void, NoParams> {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.signOut();
  }
}
