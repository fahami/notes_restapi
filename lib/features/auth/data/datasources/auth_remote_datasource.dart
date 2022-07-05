import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:notes_restapi/features/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> getUser();
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio httpClient;
  final Box<UserModel> userBox;

  AuthRemoteDataSourceImpl({required this.httpClient, required this.userBox});

  @override
  Future<UserModel> getUser() async {
    try {
      final res = await httpClient.get('/user/profile');
      return UserModel.fromJson(res.data);
    } on DioError catch (e) {
      if (e.response != null) {
        return Future.error(e.response?.data);
      } else {
        return Future.error(e);
      }
    }
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      final res = await httpClient.post('/auth/login', data: {
        'email': email,
        'password': password,
      });
      userBox.put('user', UserModel.fromJson(res.data));
      userBox.put('token', res.data['token']);
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
  Future<void> signUp(String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }
}
