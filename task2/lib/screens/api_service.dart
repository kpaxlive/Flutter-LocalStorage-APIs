import 'dart:convert';

import 'package:task_2/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String url = "https://reqres.in/api/users?page=2";
  Future<UserModel?> getUsers() async {
    final res = await http.get(Uri.parse(url));
    if (res.statusCode == 200) {
      final data = UserModel.fromJson(jsonDecode(res.body));
      return data;
    }
    return null;
  }
}
