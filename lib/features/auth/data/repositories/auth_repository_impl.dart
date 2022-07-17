import 'package:dio/dio.dart';
import 'package:notes_restapi/core/error/exception.dart';
import 'package:notes_restapi/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:notes_restapi/core/network/network_info.dart';
import 'package:notes_restapi/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:notes_restapi/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';
import 'package:notes_restapi/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> getUser() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remoteDataSource.getUser();
        localDataSource.cacheUser(res);
        return Right(res);
      } on ServerException {
        return const Left(ServerFailure());
      }
    } else {
      try {
        final res = localDataSource.getUser();
        return Right(res);
      } on CacheException {
        return const Left(CacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, User>> signIn(String email, String password) async {
    try {
      final res = await remoteDataSource.signIn(email, password);
      localDataSource.cacheUser(res);
      return Right(res);
    } catch (e) {
      return Left(ServerFailure(message: e));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } on ServerFailure {
      return const Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, User>> signUp(
    String name,
    String email,
    String password,
  ) async {
    try {
      final res = await remoteDataSource.signUp(name, email, password);
      return Right(res);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: e));
    }
  }
}
