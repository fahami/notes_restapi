import 'package:intl/intl.dart';
import 'package:notes_restapi/features/auth/data/model/user_model.dart';
import 'package:notes_restapi/features/auth/domain/entities/user.dart';
import 'package:notes_restapi/features/todo/data/model/color_model.dart';
import 'package:notes_restapi/features/todo/domain/entities/color.dart';
import 'package:notes_restapi/features/todo/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    int? id,
    required String title,
    required String isi,
    required TodoColor color,
    required DateTime reminder,
    required User user,
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
    TodoColor? color,
    DateTime? reminder,
    User? user,
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
        color: ColorModel.fromJson(json['color']),
        reminder: json['reminder'] == null
            ? DateTime.now()
            : DateTime.parse(json['reminder']),
        user: UserModel.fromJson(json['user']),
      );

  Map<String, dynamic> toJson() => {
        'title': title,
        'isi': isi,
        'reminder': "${DateFormat("yyyy-MM-ddTHH:mm:ss").format(reminder)}Z",
        'colorId': color.id,
      };
}
