import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_restapi/core/usecases/usecase.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';
import 'package:notes_restapi/features/auth/domain/usecases/signin.dart';
import 'package:notes_restapi/features/auth/domain/usecases/signout.dart';
import 'package:notes_restapi/features/auth/domain/usecases/signup.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;

  LoginCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
  }) : super(LoginInitial());

  bool isPasswordObscured = true;
  bool isConfirmObscured = true;

  void togglePasswordObscure() {
    emit(LoginObscuring());
    isPasswordObscured = !isPasswordObscured;
    emit(LoginInitial());
  }

  void toggleConfirmObscure() {
    emit(LoginObscuring());
    isConfirmObscured = !isConfirmObscured;
    emit(LoginInitial());
  }

  Future<void> signIn(String email, String password) async {
    emit(LoginLoading());
    final res = await signInUseCase(ParamsAuth(email, password));
    res.fold(
      (failure) => emit(LoginError(message: failure.message)),
      (user) => emit(LoginAuthorized(user)),
    );
  }

  Future<void> signUp(String name, String email, String password) async {
    emit(LoginLoading());
    final res = await signUpUseCase(ParamsSignup(name, email, password));
    res.fold(
      (failure) => emit(LoginError(message: failure.message)),
      (user) => emit(LoginAuthorized(user)),
    );
  }

  Future<void> signOut() async {
    emit(LoginLoading());
    final res = await signOutUseCase(NoParams());
    res.fold(
      (failure) => emit(const LoginError()),
      (_) => emit(LoginUnauthorized()),
    );
  }
}
