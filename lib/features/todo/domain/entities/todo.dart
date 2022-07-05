import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:notes_restapi/features/auth/data/model/user_model.dart';
import 'package:notes_restapi/features/todo/data/model/color_model.dart';
part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject with EquatableMixin {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String isi;
  @HiveField(3)
  ColorModel color;
  @HiveField(4)
  UserModel user;
  @HiveField(5)
  DateTime reminder;

  Todo({
    this.id,
    required this.title,
    required this.isi,
    required this.color,
    required this.reminder,
    required this.user,
  });

  @override
  List<Object?> get props => [id, title, isi, color, reminder, user];
}
