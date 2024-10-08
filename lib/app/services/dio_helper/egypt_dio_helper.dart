import 'package:coffee_wonders/app/services/shared_prefrences/cache_helper.dart';
import 'package:dio/dio.dart';

import '../../constant/egypt_api_constant.dart';

class EgyptDioHelper {
  static late Dio dio;
  static void init() {
    dio = Dio(
      BaseOptions(
        receiveDataWhenStatusError: true,
        baseUrl: EgyptApiConstant.baseUrl,
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization':
              'Bearer ${CacheHelper.getData(key: SharedKey.egyptToken)}',
        },
      ),
    );
  }

  static Future<Response> getData({
    required String path,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
    String? token,
  }) async {
    // dio.options.headers = {
    //   'Authorization': 'Bearer $token',
    // };
    return await dio.get(path, queryParameters: queryParameters, data: body);
  }

  static Future<Response> postData({
    required String path,
    Map<String, dynamic>? queryParameters,
    dynamic data,
    String? token,
  }) async {
    // dio.options.headers = {
    //   'Authorization': 'Bearer $token',
    //   'Accept': 'application/json',
    //   'Content-Type': 'application/json'
    // };
    return await dio.post(path, data: data);
  }

  static Future<Response> delData({
    required String path,
    Map<String, dynamic>? queryParameters,
    String? token,
    dynamic data,
  }) async {
    // dio.options.headers = {
    //   'Authorization': 'Bearer $token',
    // };
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
    // dio.options.headers = {
    //   'Authorization': 'Bearer $token',
    //   'Accept': 'application/json',
    //   'Content-Type': 'application/json'
    // };
    return await dio.put(
      path,
      data: data,
    );
  }
}
