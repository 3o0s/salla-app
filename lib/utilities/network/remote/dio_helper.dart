import 'package:dio/dio.dart';
import 'package:shopapp/utilities/network/end_points.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    required String path,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) {
    dio.options.headers = {
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
      'lang': lang,
    };
    return dio.post(
      path,
      data: data,
    );
  }

  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
    String lang = 'en',
    String? token,
  }) {
    dio.options.headers = {
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
      'lang': lang,
    };

    return dio.get(
      url,
      queryParameters: query,
    );
  }

  static Future<Response> putData(
    String path, {
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
    String lang = 'en',
    String? token,
  }) {
    dio.options.headers = {
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
      'lang': lang,
    };
    return dio.put(
      path,
      queryParameters: query,
      data: data,
    );
  }
}
