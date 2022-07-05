import 'package:notes_restapi/features/auth/data/model/user_model.dart';
import 'package:notes_restapi/features/todo/data/model/color_model.dart';
import 'package:notes_restapi/features/todo/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    int? id,
    required String title,
    required String isi,
    required ColorModel color,
    required DateTime reminder,
    required UserModel user,
  }) : super(
            id: id,
            title: title,
            isi: isi,
            color: color,
            reminder: reminder,
            user: user);

  TodoModel copyWith({
    int? id,
    String? title,
    String? isi,
    ColorModel? color,
    DateTime? reminder,
    UserModel? user,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isi: isi ?? this.isi,
      color: color ?? this.color,
      reminder: reminder ?? this.reminder,
      user: user ?? this.user,
    );
  }

  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json['id'],
        title: json['title'],
        isi: json['isi'],
        color: json['color'],
        reminder: json['reminder'],
        user: json['user'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'isi': isi,
        'color': color,
        'reminder': reminder.toIso8601String(),
        'user': user,
      };
}
