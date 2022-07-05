import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
part 'color.g.dart';

@HiveType(typeId: 1)
class TodoColor extends HiveObject with EquatableMixin {
  @HiveField(0)
  int id;
  @HiveField(1)
  final String colorType;
  @HiveField(2)
  final String colorName;

  TodoColor(this.id, this.colorType, this.colorName);

  @override
  List<Object?> get props => [id, colorType, colorName];
}
