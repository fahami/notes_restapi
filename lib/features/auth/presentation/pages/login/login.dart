import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_restapi/core/theme/color_theme.dart';
import 'package:notes_restapi/core/theme/text_theme.dart';
import 'package:notes_restapi/di.dart';
import 'package:notes_restapi/features/auth/presentation/cubit/auth_cubit_cubit.dart';
import 'package:notes_restapi/features/todo/presentation/widgets/custom_button.dart';
import 'package:notes_restapi/features/todo/presentation/widgets/custom_dialog.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                          borderSide: BorderSide(color: ThemeColor.typography)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: 48,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      suffixIcon: const Icon(Icons.visibility_off_outlined),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(200),
                          borderSide: BorderSide(color: ThemeColor.typography)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: CustomButton(
                    text: "Masuk",
                    onPressed: () {
                      sl<AuthCubit>().signIn(
                          _emailController.text, _passwordController.text);
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
                          )).then((value) => GoRouter.of(context).go('/notes'));
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
                        onPressed: () => GoRouter.of(context).go('/register'),
                        child: const Text("Daftar Sekarang")),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
