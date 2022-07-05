import 'package:dartz/dartz.dart';
import 'package:notes_restapi/core/error/failures.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, void>> signIn(String email, String password);
  Future<Either<Failure, void>> signUp(String email, String password);
  Future<Either<Failure, void>> signOut();
}
