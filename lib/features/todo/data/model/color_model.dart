import 'package:notes_restapi/features/todo/domain/entities/color.dart';

class ColorModel extends TodoColor {
  ColorModel({
    required int id,
    required String colorName,
    required String colorType,
  }) : super(id, colorName, colorType);

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
