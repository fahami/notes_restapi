import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notes_restapi/core/router/router.dart';
import 'package:notes_restapi/core/util/bloc_observer.dart';
import 'package:notes_restapi/di.dart' as di;
import 'package:notes_restapi/di.dart';
import 'package:notes_restapi/features/auth/data/model/user_model.dart';
import 'package:notes_restapi/features/todo/presentation/bloc/edit_todo_bloc.dart';
import 'package:notes_restapi/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:notes_restapi/features/todo/presentation/cubit/color_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static final Box<UserModel> userBox = Hive.box('user');

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                sl<TodoBloc>()..add(GetTodosEvent(userBox.get('user')!))),
        BlocProvider(
          create: (context) => sl<ColorCubit>()..getColors(),
        ),
        BlocProvider(
          create: (context) => sl<EditTodoBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'NotApp',
        routeInformationParser: AppRouter.router.routeInformationParser,
        routerDelegate: AppRouter.router.routerDelegate,
      ),
    );
  }
}
