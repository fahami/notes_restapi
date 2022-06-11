import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String? name;
  final String? token;
  final String? email;
  const User(this.id, this.name, this.email, this.token);

  @override
  List<Object?> get props => [id, name, email, token];
}
