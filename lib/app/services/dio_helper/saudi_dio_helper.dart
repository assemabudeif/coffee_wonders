import 'package:dio/dio.dart';

import '../../constant/saudi_api_constant.dart';

class SaudiDioHelper {
  static late Dio dio;
  static void init() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: SaudiApiConstant.baseUrl,
      ),
    );
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? queryParameters,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return await dio.get(path, queryParameters: queryParameters);
  }

  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    return await dio.post(path, data: data);
  }

  static Future<Response> delData({
    required String path,
    Map<String, dynamic>? queryParameters,
    String? token,
    dynamic data,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
    };
    return await dio.delete(
      path,
    );
  }

  static Future<Response> updateData({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    String? token,
  }) async {
    dio.options.headers = {
      'Authorization': 'Bearer $token',
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    };
    return await dio.put(
      path,
      data: data,
    );
  }
}
