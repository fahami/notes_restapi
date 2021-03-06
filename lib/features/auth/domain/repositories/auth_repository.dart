import 'package:dartz/dartz.dart';
import 'package:notes_restapi/core/error/failures.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, User>> signIn(String email, String password);
  Future<Either<Failure, User>> signUp(
    String name,
    String email,
    String password,
  );
  Future<Either<Failure, void>> signOut();
}
