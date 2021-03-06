import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 2)
class User extends HiveObject with EquatableMixin {
  @HiveField(0)
  int id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String email;
  @HiveField(3)
  String? token;
  @HiveField(4)
  String? password;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.token,
    this.password,
  });

  @override
  List<Object?> get props => [id, name, email, token, password];
}
