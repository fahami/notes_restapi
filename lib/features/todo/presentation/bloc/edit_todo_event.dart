part of 'edit_todo_bloc.dart';

abstract class EditTodoEvent extends Equatable {
  const EditTodoEvent();

  @override
  List<Object> get props => [];
}

class EditInitial extends EditTodoEvent {}

class EditLoad extends EditTodoEvent {
  final int todoId;

  const EditLoad(this.todoId);

  @override
  List<Object> get props => [todoId];
}

class EditUpdate extends EditTodoEvent {
  final TodoModel todo;

  const EditUpdate({required this.todo});

  @override
  List<Object> get props => [todo];
}

class EditNew extends EditTodoEvent {
  final TodoModel todo;

  const EditNew({required this.todo});

  @override
  List<Object> get props => [todo];
}

class EditDelete extends EditTodoEvent {
  final int todoId;

  const EditDelete(this.todoId);

  @override
  List<Object> get props => [todoId];
}

class EditChangeColor extends EditTodoEvent {
  final Color color;

  const EditChangeColor({required this.color});

  @override
  List<Object> get props => [color];
}
