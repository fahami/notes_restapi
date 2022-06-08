import 'package:dio/dio.dart';
import 'package:notes_restapi/core/error/exception.dart';
import 'package:notes_restapi/features/todo/data/model/color_model.dart';

abstract class ColorRemoteDataSource {
  Future<List<ColorModel>> getColors();
}

class ColorRemoteDataSourceImpl extends ColorRemoteDataSource {
  final Dio fireStore;

  ColorRemoteDataSourceImpl(this.fireStore);

  @override
  Future<List<ColorModel>> getColors() {
    // TODO: implement getColors
    throw UnimplementedError();
  }
}
