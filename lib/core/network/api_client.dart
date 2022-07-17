import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notes_restapi/core/values/strings.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

var token = GetStorage();
final Dio dio = Dio(
  BaseOptions(
    baseUrl: Values.baseAPI,
    connectTimeout: 10000,
    receiveTimeout: 7000,
    headers: {'Authorization': token.read('token')},
  ),
)..interceptors.add(PrettyDioLogger(requestHeader: true));
