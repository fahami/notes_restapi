import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:notes_restapi/features/auth/data/model/user_model.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> getUser();
  Future<UserModel> signIn(String email, String password);
  Future<void> signUp(String name, String email, String password);
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio httpClient;
  final Box<UserModel> userBox;

  AuthRemoteDataSourceImpl(this.httpClient, this.userBox);

  @override
  Future<UserModel> getUser() async {
    try {
      final res = await httpClient.get('/user/profile');
      return UserModel.fromJson(res.data['data']);
    } on DioError catch (e) {
      if (e.response != null) {
        return Future.error(e.response?.data);
      } else {
        return Future.error(e);
      }
    }
  }

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      final res = await httpClient.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      userBox.put('user', UserModel.fromJson(res.data['data']));
      return UserModel.fromJson(res.data['data']);
    } on DioError catch (e) {
      if (e.response != null) {
        return Future.error(e.response?.data);
      } else {
        return Future.error(e);
      }
    }
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(String name, String email, String password) async {
    try {
      final res = await httpClient.post('/auth/register', data: {
        'name': name,
        'email': email,
        'password': password,
      });
      userBox.put('user', UserModel.fromJson(res.data['data']));
    } on DioError catch (e) {
      if (e.response != null) {
        return Future.error(e.response?.data);
      } else {
        return Future.error(e);
      }
    }
  }
}
