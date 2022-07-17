import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_restapi/core/theme/color_theme.dart';
import 'package:notes_restapi/core/theme/text_theme.dart';
import 'package:notes_restapi/di.dart';
import 'package:notes_restapi/features/auth/presentation/cubit/login_cubit.dart';
import 'package:notes_restapi/features/todo/presentation/widgets/custom_button.dart';
import 'package:notes_restapi/features/todo/presentation/widgets/custom_dialog.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginError) {
          Navigator.pop(context);
          showCustomDialog(
              context,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error,
                    color: ThemeColor.pinky,
                    size: 48,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "${state.message}",
                    style: ThemeText.titleStyle
                        .copyWith(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ],
              ));
        }
        if (state is LoginLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Dialog(
              insetPadding: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 10),
                    const Text('Loading...'),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is LoginAuthorized) {
          showCustomDialog(
              context,
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.check_circle,
                    color: ThemeColor.greenish,
                    size: 48,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Login berhasil",
                    style: ThemeText.titleStyle
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              )).then((_) => GoRouter.of(context).go('/notes'));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/hero.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Masuk",
                      style: ThemeText.heroStyle.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 48,
                      child: TextField(
                        controller: _emailController,
                        enableSuggestions: true,
                        decoration: InputDecoration(
                          hintText: "Email",
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(200),
                              borderSide:
                                  BorderSide(color: ThemeColor.typography)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 48,
                      child: TextField(
                        controller: _passwordController,
                        obscureText:
                            context.read<LoginCubit>().isPasswordObscured,
                        decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: IconButton(
                            icon: Icon(
                              context.read<LoginCubit>().isPasswordObscured ==
                                      false
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              context
                                  .read<LoginCubit>()
                                  .togglePasswordObscure();
                            },
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(200),
                              borderSide:
                                  BorderSide(color: ThemeColor.typography)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 16),
                      child: CustomButton(
                        text: "Masuk",
                        onPressed: () {
                          context.read<LoginCubit>().signIn(
                                _emailController.text,
                                _passwordController.text,
                              );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () =>
                                GoRouter.of(context).go('/forgot-password'),
                            child: const Text("Lupa kata sandi?")),
                      ],
                    ),
                    Row(
                      children: [
                        const Text("Belum punya akun? "),
                        TextButton(
                            onPressed: () =>
                                GoRouter.of(context).go('/register'),
                            child: const Text("Daftar Sekarang")),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
