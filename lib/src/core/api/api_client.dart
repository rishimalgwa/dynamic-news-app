import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../constants/urls.dart';

@lazySingleton
class ApiClient {
  final Dio dio;

  ApiClient(this.dio) {
    final baseOptions = BaseOptions(
        baseUrl: rootURL,
        contentType: "application/json",
        validateStatus: (status) => status != null ? status < 500 : false);
    dio.options = baseOptions;
    dio.interceptors.addAll([
      LogInterceptor(),
    ]);
  }
}
