import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:notes_restapi/core/router/router.dart';
import 'package:notes_restapi/core/util/bloc_observer.dart';
import 'package:notes_restapi/di.dart' as di;
import 'package:notes_restapi/di.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';
import 'package:notes_restapi/features/todo/presentation/bloc/edit_todo_bloc.dart';
import 'package:notes_restapi/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:notes_restapi/features/todo/presentation/cubit/color_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  BlocOverrides.runZoned(
    () => runApp(MyApp()),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final userBox = sl<Box<User>>();

  @override
  Widget build(BuildContext context) {
    // userBox.clear();
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
