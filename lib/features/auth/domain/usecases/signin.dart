import 'package:dartz/dartz.dart';
import 'package:notes_restapi/core/error/failures.dart';
import 'package:notes_restapi/core/usecases/usecase.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';
import 'package:notes_restapi/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase extends UseCase<User, ParamsAuth> {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(ParamsAuth params) {
    return repository.signIn(params.email, params.password);
  }
}

class ParamsAuth {
  final String email;
  final String password;
  ParamsAuth(this.email, this.password);
}
