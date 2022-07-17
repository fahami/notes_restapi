import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_restapi/core/theme/color_theme.dart';
import 'package:notes_restapi/core/theme/text_theme.dart';
import 'package:notes_restapi/di.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';
import 'package:notes_restapi/features/auth/presentation/cubit/login_cubit.dart';

class UserScreen extends StatelessWidget {
  UserScreen({Key? key}) : super(key: key);

  final userBox = sl<Box<User>>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginUnauthorized) {
          GoRouter.of(context).go('/');
        }
      },
      builder: (context, state) {
        return Scaffold(
            body: SafeArea(
                child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              children: [
                CircleAvatar(
                  backgroundColor: ThemeColor.disabled,
                  radius: 50,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: ThemeColor.typography,
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.perm_identity),
                  title: Text(
                    "Nama",
                    style: ThemeText.alternativeStyle.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    userBox.get('user')?.name ?? "",
                  ),
                ),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.alternate_email_outlined),
                  title: Text(
                    "Email",
                    style: ThemeText.alternativeStyle.copyWith(
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    userBox.get('user')?.email ?? "",
                  ),
                ),
                // ListTile(
                //   leading: const Icon(Icons.login_outlined),
                //   title: Text(
                //     "Terakhir masuk",
                //     style: ThemeText.alternativeStyle.copyWith(
                //       fontSize: 20,
                //     ),
                //   ),
                //   subtitle: Text(
                //     simpleDate(DateTime.now().toIso8601String()),
                //   ),
                // ),
                // ListTile(
                //   leading: const Icon(Icons.person_add_outlined),
                //   title: Text(
                //     "Akun dibuat pada",
                //     style: ThemeText.alternativeStyle.copyWith(
                //       fontSize: 20,
                //     ),
                //   ),
                //   subtitle: Text(
                //     simpleDate(DateTime.now().toIso8601String()),
                //   ),
                // ),
                // ListTile(
                //   leading: const Icon(Icons.password_outlined),
                //   title: Text(
                //     "Atur ulang sandi",
                //     style: ThemeText.alternativeStyle.copyWith(
                //       fontSize: 20,
                //     ),
                //   ),
                //   subtitle: ConstrainedBox(
                //     constraints: BoxConstraints(
                //       minWidth: 0,
                //       maxWidth: MediaQuery.of(context).size.width * 0.6,
                //     ),
                //     child: TextButton(
                //       onPressed: () async {
                //         await _auth.sendPasswordResetEmail(
                //             email: _auth.currentUser!.email!);
                //         await showCustomDialog(
                //           context,
                //           Column(
                //             mainAxisSize: MainAxisSize.min,
                //             children: [
                //               Icon(
                //                 Icons.check_circle,
                //                 color: ThemeColor.greenish,
                //                 size: 48,
                //               ),
                //               const SizedBox(height: 20),
                //               Text(
                //                 "Instruksi dikirim",
                //                 style: ThemeText.titleStyle
                //                     .copyWith(fontWeight: FontWeight.bold),
                //               ),
                //             ],
                //           ),
                //         );
                //       },
                //       style: TextButton.styleFrom(
                //         primary: ThemeColor.accentColor,
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(8),
                //           side: BorderSide(color: ThemeColor.accentColor),
                //         ),
                //       ),
                //       child: Text(
                //         key: const Key("logout_button"),
                //         "atur ulang sandi",
                //         style: ThemeText.bodyStyle,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            )),
            bottomNavigationBar: SafeArea(
              child: Container(
                margin: const EdgeInsets.all(16),
                child: TextButton(
                  onPressed: () => context.read<LoginCubit>().signOut(),
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: ThemeColor.accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: Text(
                    key: const Key("logout_button"),
                    "Keluar",
                    style: ThemeText.bodyStyle,
                  ),
                ),
              ),
            ));
      },
    );
  }
}
