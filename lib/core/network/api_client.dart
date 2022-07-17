import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:notes_restapi/core/values/strings.dart';
import 'package:notes_restapi/di.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

String? get token => sl<GetStorage>().read('token');
Dio get dio => Dio(
      BaseOptions(
        baseUrl: Values.baseAPI,
        connectTimeout: 10000,
        receiveTimeout: 7000,
        headers: {'Authorization': token},
      ),
    )..interceptors.add(
        PrettyDioLogger(
          responseBody: false,
          requestHeader: true,
        ),
      );
