import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';
import 'package:notes_restapi/features/auth/domain/usecases/signin.dart';

part 'auth_cubit_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  final SignInUseCase signInUseCase;
  AuthCubit(this.signInUseCase) : super(AuthCubitInitial());

  void signIn(String email, String password) {
    emit(AuthCubitLoading());
    final res = signInUseCase(ParamsAuth(email, password));
    res.then((value) => value.fold(
          (failure) => emit(AuthCubitError()),
          (user) => emit(AuthCubitLoaded(user)),
        ));
  }
}
