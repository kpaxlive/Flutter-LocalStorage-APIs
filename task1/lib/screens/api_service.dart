import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:task_1/models/character_model.dart';

class ApiService {
  final String url = "https://rickandmortyapi.com/api/character";

  Future<CharacterModel> fetchCharacters() async{
    final res = await http.get(Uri.parse(url));
    
    if(res.statusCode == 200)
    {
      return CharacterModel.fromJson(jsonDecode(res.body));
    }
    else
    {
      throw Exception("Failed to get data from api");
    }
  }
}
