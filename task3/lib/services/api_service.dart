// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:task_3/models/color_model.dart';

class ApiService {
  String url = 'https://reqres.in/api/unknown';
  final Dio dio = Dio();

  Future<List<ColorModel>> getData() async {
    final res = await dio.get(url);

    if (res.statusCode == 200) {
      List<ColorModel> colors = [];

      for (var item in res.data['data']) {
        if (item is Map<String, dynamic>) {
          colors.add(ColorModel(
            id: item['id'] as int?,
            name: item['name'] as String?,
            year: item['year'] as int?,
            color: item['color'] as String?,
            pantoneValue: item['pantoneValue'] as String?,
          ));
        }
      }
      return colors;
    } else {
      print(res.statusCode);
      return [] as List<ColorModel>;
    }
  }

  Future<String> sendPostRequest() async {
    final data = {"name": "morpheus", "job": "leader"};
    try {
      final response = await dio.post('https://reqres.in/api/user', data: data);
      print(response);
      return response.data.toString();
      // ignore: deprecated_member_use
    } on DioError catch (e) {
      return 'Failed to post data: ${e.message}';
    }
  }
}

class AuthenticatedDio {
  late Dio dio;
  String token = '';

    AuthenticatedDio({required String baseUrl}) {
    dio = Dio(BaseOptions(baseUrl: baseUrl));
    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Log the whole request including headers
        print('Request: ${options.method} ${options.uri}');
        print('Headers: ${options.headers}');
        print('Data: ${options.data}');
        
        options.headers['Authorization'] = 'Bearer $token';
        return handler.next(options);
      },
    ));
  }


  Future<void> authenticate() async {
    try {
      final data = {"email": "eve.holt@reqres.in", "password": "pistol"};

      final response =
          await dio.post('https://reqres.in/api/register', data: data);

      if (response.statusCode == 200) {
        Map<String, dynamic> dataRes = response.data;
        token = dataRes['token']!;
        print(token);
      } 
    } catch (e) {
      print('Authentication failed: $e');
      rethrow;
    }
  }
}
