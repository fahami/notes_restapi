import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';
import 'package:notes_restapi/features/auth/presentation/pages/forgot_password/forgot_password.dart';
import 'package:notes_restapi/features/auth/presentation/pages/login/login.dart';
import 'package:notes_restapi/features/auth/presentation/pages/onboard/onboard.dart';
import 'package:notes_restapi/features/todo/presentation/pages/error/error.dart';
import 'package:notes_restapi/features/auth/presentation/pages/register/register.dart';
import 'package:notes_restapi/features/todo/presentation/pages/note/note.dart';
import 'package:notes_restapi/features/todo/presentation/pages/notes/notes.dart';

class AppRouter {
  static final Box<User> userBox = Hive.box('user');
  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const OnboardScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: '/notes',
        builder: (context, state) => NotesScreen(),
      ),
      GoRoute(
        path: '/note/new',
        builder: (context, state) => const NoteDetailScreen(isNew: true),
      ),
      GoRoute(
        path: '/note/:id',
        builder: (context, state) =>
            NoteDetailScreen(id: int.tryParse(state.params['id']!)),
      ),
    ],
    errorBuilder: (context, state) => const ErrorScreen(),
    initialLocation: userBox.containsKey('user') ? '/notes' : '/',
  );
}
