part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class GetTodosEvent extends TodoEvent {
  final User user;

  const GetTodosEvent(this.user);

  @override
  List<Object> get props => [user];
}

class DeleteAllTodoEvent extends TodoEvent {
  final int userId;

  const DeleteAllTodoEvent(this.userId);

  @override
  List<Object> get props => [userId];
}

class DeleteTodoEvent extends TodoEvent {
  final int todoId;

  const DeleteTodoEvent(this.todoId);

  @override
  List<Object> get props => [todoId];
}

class SearchTodoEvent extends TodoEvent {
  final String query;

  const SearchTodoEvent(this.query);

  @override
  List<Object> get props => [query];
}
