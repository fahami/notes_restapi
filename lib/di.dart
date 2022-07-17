import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:notes_restapi/core/network/api_client.dart';
import 'package:notes_restapi/core/network/network_info.dart';
import 'package:notes_restapi/features/auth/data/datasources/auth_local_datasource.dart';
import 'package:notes_restapi/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:notes_restapi/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';
import 'package:notes_restapi/features/auth/domain/repositories/auth_repository.dart';
import 'package:notes_restapi/features/auth/domain/usecases/get_user.dart';
import 'package:notes_restapi/features/auth/domain/usecases/signin.dart';
import 'package:notes_restapi/features/auth/domain/usecases/signout.dart';
import 'package:notes_restapi/features/auth/domain/usecases/signup.dart';
import 'package:notes_restapi/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:notes_restapi/features/todo/data/datasources/color_local_datasource.dart';
import 'package:notes_restapi/features/todo/data/datasources/color_remote_datasource.dart';
import 'package:notes_restapi/features/todo/data/datasources/todo_local_datasource.dart';
import 'package:notes_restapi/features/todo/data/datasources/todo_remote_datasource.dart';
import 'package:notes_restapi/features/todo/data/repositories/color_repository_impl.dart';
import 'package:notes_restapi/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:notes_restapi/features/todo/domain/entities/color.dart';
import 'package:notes_restapi/features/todo/domain/entities/todo.dart';
import 'package:notes_restapi/features/todo/domain/repositories/colors_repository.dart';
import 'package:notes_restapi/features/todo/domain/repositories/todos_repository.dart';
import 'package:notes_restapi/features/todo/domain/usecases/add_todo.dart';
import 'package:notes_restapi/features/todo/domain/usecases/delete_all_todo.dart';
import 'package:notes_restapi/features/todo/domain/usecases/delete_todo.dart';
import 'package:notes_restapi/features/todo/domain/usecases/get_colors.dart';
import 'package:notes_restapi/features/todo/domain/usecases/get_todo_by_id.dart';
import 'package:notes_restapi/features/todo/domain/usecases/get_todos.dart';
import 'package:notes_restapi/features/todo/domain/usecases/update_todo.dart';
import 'package:notes_restapi/features/todo/presentation/bloc/edit_todo_bloc.dart';
import 'package:notes_restapi/features/todo/presentation/bloc/todo_bloc.dart';
import 'package:notes_restapi/features/todo/presentation/cubit/color_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  GetStorage.init();
  // bloc
  sl.registerFactory(
    () => TodoBloc(
      getTodos: sl(),
      deleteAllTodo: sl(),
    ),
  );
  // cubit
  sl.registerFactory(() => AuthCubit(
        signInUseCase: sl(),
        signUpUseCase: sl(),
        signOutUseCase: sl(),
      ));
  sl.registerFactory(() => ColorCubit(sl()));
  sl.registerFactory(() => EditTodoBloc(
        addTodo: sl(),
        deleteTodo: sl(),
        getTodoById: sl(),
        updateTodo: sl(),
      ));

  // todo usecases
  sl.registerLazySingleton(() => GetTodos(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));
  sl.registerLazySingleton(() => DeleteAllTodo(sl()));
  sl.registerLazySingleton(() => GetTodoById(sl()));
  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));
  // color usecase
  sl.registerLazySingleton(() => GetTodoColor(sl()));
  // auth usecase
  sl.registerLazySingleton(() => GetUserUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));

  // repository
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<TodoColorsRepository>(
    () => TodoColorRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      localDataSource: sl(),
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // data sources
  sl.registerLazySingleton<TodoLocalDataSource>(
      () => TodoLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<TodoRemoteDataSource>(
      () => TodoRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ColorRemoteDataSource>(
      () => ColorRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<ColorLocalDataSource>(
      () => ColorLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(sl()));
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(sl(), sl()));

  // storage
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TodoColorAdapter());
  await Hive.openBox<Todo>('todos');
  await Hive.openBox<TodoColor>('colors');
  await Hive.openBox<User>('user');
  final Box<Todo> todoBox = Hive.box('todos');
  final Box<TodoColor> colorBox = Hive.box('colors');
  final Box<User> userBox = Hive.box('user');
  // api services
  final Dio httpClient = dio;
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => httpClient);
  sl.registerLazySingleton(() => todoBox);
  sl.registerLazySingleton(() => colorBox);
  sl.registerLazySingleton(() => userBox);
}
