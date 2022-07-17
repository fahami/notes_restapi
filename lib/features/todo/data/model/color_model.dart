import 'package:notes_restapi/features/todo/domain/entities/color.dart';

class ColorModel extends TodoColor {
  ColorModel({
    required int id,
    required String colorType,
    required String colorName,
  }) : super(id, colorType, colorName);

  factory ColorModel.fromJson(Map<String, dynamic> json) => ColorModel(
        id: json['id'],
        colorType: json['color_type'],
        colorName: json['color_name'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'color_type': colorType,
        'color_name': colorName,
      };
}
