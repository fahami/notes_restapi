import 'package:hive/hive.dart';
import 'package:notes_restapi/core/error/exception.dart';
import 'package:notes_restapi/features/todo/data/model/color_model.dart';
import 'package:notes_restapi/features/todo/domain/entities/color.dart';

abstract class ColorLocalDataSource {
  Future<List<ColorModel>> getColors();
  Future<void> cacheColor(ColorModel colorToCache);
}

class ColorLocalDataSourceImpl extends ColorLocalDataSource {
  final Box<TodoColor> hiveBox;

  ColorLocalDataSourceImpl(this.hiveBox);

  @override
  Future<List<ColorModel>> getColors() async {
    final colors = hiveBox.values.toList();
    if (colors.isNotEmpty) {
      return colors as List<ColorModel>;
    } else {
      throw CacheException('No colors found');
    }
  }

  @override
  Future<void> cacheColor(ColorModel colorToCache) {
    return hiveBox.put(colorToCache.id, colorToCache);
  }
}
