import 'package:dio/dio.dart';
import 'package:notes_restapi/features/todo/data/model/color_model.dart';

abstract class ColorRemoteDataSource {
  Future<List<ColorModel>> getColors();
}

class ColorRemoteDataSourceImpl extends ColorRemoteDataSource {
  final Dio http;

  ColorRemoteDataSourceImpl(this.http);

  @override
  Future<List<ColorModel>> getColors() async {
    return await http.get('/color').then((res) => res.data['data']
        .map<ColorModel>((e) => ColorModel.fromJson(e))
        .toList());
  }
}
