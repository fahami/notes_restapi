import 'package:hive/hive.dart';
import 'package:notes_restapi/core/error/exception.dart';
import 'package:notes_restapi/features/auth/data/model/user_model.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';

abstract class AuthLocalDataSource {
  UserModel getUser();
  Future<void> cacheUser(UserModel user);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Box<User> userBox;

  AuthLocalDataSourceImpl(this.userBox);

  @override
  UserModel getUser() {
    try {
      return userBox.get('user') as UserModel;
    } catch (e) {
      throw CacheException('Error getting user from cache');
    }
  }

  @override
  Future<void> cacheUser(UserModel user) {
    try {
      return userBox.put('user', user);
    } catch (e) {
      throw CacheException('Error caching user');
    }
  }
}
