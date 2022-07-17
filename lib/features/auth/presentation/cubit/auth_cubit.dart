import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';
import 'package:notes_restapi/features/auth/domain/usecases/signin.dart';
import 'package:notes_restapi/features/auth/domain/usecases/signout.dart';
import 'package:notes_restapi/features/auth/domain/usecases/signup.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final SignOutUseCase signOutUseCase;

  AuthCubit({
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.signOutUseCase,
  }) : super(AuthCubitInitial());

  void signIn(String email, String password) {
    emit(AuthCubitLoading());
    final res = signInUseCase(ParamsAuth(email, password));
    res.then((value) => value.fold(
          (failure) => emit(AuthCubitError()),
          (user) => emit(AuthCubitLoaded(user)),
        ));
  }

  void signUp(String name, String email, String password) {
    emit(AuthCubitLoading());
    final res = signUpUseCase(ParamsSignup(name, email, password));
    res.then((value) => value.fold(
          (failure) => emit(AuthCubitError()),
          (user) => emit(AuthCubitLoaded(user)),
        ));
  }
}
