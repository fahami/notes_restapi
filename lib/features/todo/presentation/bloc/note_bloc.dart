import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes_restapi/core/usecases/usecase.dart';
import 'package:notes_restapi/features/todo/data/model/todo_model.dart';
import 'package:notes_restapi/features/todo/domain/entities/todo.dart';
import 'package:notes_restapi/features/todo/domain/usecases/add_todo.dart';
import 'package:notes_restapi/features/todo/domain/usecases/delete_all_todo.dart';
import 'package:notes_restapi/features/todo/domain/usecases/delete_todo.dart';
import 'package:notes_restapi/features/todo/domain/usecases/get_todo_by_id.dart';
import 'package:notes_restapi/features/todo/domain/usecases/get_todos.dart';
import 'package:notes_restapi/features/todo/domain/usecases/params_todo.dart';
import 'package:notes_restapi/features/todo/domain/usecases/update_todo.dart';

part 'note_event.dart';
part 'note_state.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final AddTodo addTodo;
  final DeleteTodo deleteTodo;
  final GetTodos getTodos;
  final GetTodoById getTodoById;
  final UpdateTodo updateTodo;
  final DeleteAllTodo deleteAllTodo;

  NoteBloc({
    required this.addTodo,
    required this.deleteTodo,
    required this.getTodos,
    required this.getTodoById,
    required this.updateTodo,
    required this.deleteAllTodo,
  }) : super(Initial()) {
    on<AddEvent>((event, emit) async {
      emit(Loading());
      final failureOrTodo = await addTodo(Params(todo: event.todo));
      failureOrTodo.fold(
        (failure) => emit(Error()),
        (todo) => emit(const Loaded()),
      );
    });
    on<DeleteTodoEvent>((event, emit) async {
      emit(Loading());
      final failureOrTodo = await deleteTodo(Params(todo: event.todo));
      failureOrTodo.fold(
        (failure) => emit(Error()),
        (todo) => emit(const Loaded()),
      );
    });
    on<GetTodosEvent>((event, emit) async {
      emit(Loading());
      final failureOrTodos = await getTodos(NoParams());
      failureOrTodos.fold(
        (failure) => emit(Error()),
        (todos) => emit(Loaded(todos: todos)),
      );
    });
    on<GetTodoByIdEvent>((event, emit) {
      getTodoById(event.todoId).then(
        (failureOrTodo) => failureOrTodo.fold(
          (failure) => emit(Error()),
          (todo) => emit(Loaded(todos: [todo])),
        ),
      );
    });
    on<UpdateTodoEvent>((event, emit) async {
      emit(Loading());
      final failureOrTodo = await updateTodo(Params(todo: event.todo));
      failureOrTodo.fold(
        (failure) => emit(Error()),
        (todo) => emit(const Loaded()),
      );
    });
    on<DeleteAllTodoEvent>((event, emit) async {
      emit(Loading());
      final failureOrTodo = await deleteAllTodo(NoParams());
      failureOrTodo.fold(
        (failure) => emit(Error()),
        (todo) => emit(const Loaded()),
      );
    });
  }
}
