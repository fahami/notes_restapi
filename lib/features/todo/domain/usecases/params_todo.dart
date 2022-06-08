import 'package:equatable/equatable.dart';
import 'package:notes_restapi/features/todo/data/model/todo_model.dart';

class Params extends Equatable {
  final TodoModel todo;

  const Params({required this.todo});

  @override
  List<Object?> get props => [todo];
}
