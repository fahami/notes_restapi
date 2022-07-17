import 'package:dartz/dartz.dart';
import 'package:notes_restapi/core/error/failures.dart';
import 'package:notes_restapi/core/usecases/usecase.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';
import 'package:notes_restapi/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase extends UseCase<User, ParamsSignup> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, User>> call(ParamsSignup params) {
    return repository.signUp(params.name, params.email, params.password);
  }
}

class ParamsSignup {
  final String name;
  final String email;
  final String password;
  ParamsSignup(this.name, this.email, this.password);
}
