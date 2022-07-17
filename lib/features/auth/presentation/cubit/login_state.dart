part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginObscuring extends LoginState {}

class LoginUnauthorized extends LoginState {}

class LoginLoading extends LoginState {}

class LoginAuthorized extends LoginState {
  final User user;

  const LoginAuthorized(this.user);

  @override
  List<Object> get props => [user];
}

class LoginError extends LoginState {
  final String? message;

  const LoginError({this.message});

  @override
  List<Object?> get props => [message];
}
