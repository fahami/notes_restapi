import 'package:dartz/dartz.dart';
import 'package:notes_restapi/core/error/failures.dart';
import 'package:notes_restapi/core/usecases/usecase.dart';
import 'package:notes_restapi/features/auth/domain/repositories/auth_repository.dart';
import 'package:notes_restapi/features/auth/domain/usecases/params_user.dart';

class SignInUseCase extends UseCase<void, ParamsUser> {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(ParamsUser params) {
    return repository.signIn(params.user.email, params.user.password ?? '');
  }
}
