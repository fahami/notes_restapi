import 'package:equatable/equatable.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';

class ParamsUser extends Equatable {
  final User user;

  const ParamsUser({required this.user});

  @override
  List<Object?> get props => [user];
}
