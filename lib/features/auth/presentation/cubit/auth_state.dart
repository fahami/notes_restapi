part of 'auth_cubit.dart';

abstract class AuthCubitState extends Equatable {
  const AuthCubitState();

  @override
  List<Object> get props => [];
}

class AuthCubitInitial extends AuthCubitState {}

class AuthCubitLoading extends AuthCubitState {}

class AuthCubitLoaded extends AuthCubitState {
  final User user;

  const AuthCubitLoaded(this.user);

  @override
  List<Object> get props => [user];
}

class AuthCubitError extends AuthCubitState {}
