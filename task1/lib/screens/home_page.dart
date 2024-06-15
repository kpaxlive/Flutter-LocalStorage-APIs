import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_1/models/character_model.dart';
import 'package:task_1/models/components/character_card.dart';
import 'package:task_1/screens/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final ApiService api;
  List<Result> characters = [];

  @override
  void initState() {
    super.initState();
    api = ApiService();
    getCharacters();
  }

  Future<List<Result>> getCharacters() async {
    final res = await api.fetchCharacters();
    characters = res.results!;
    return characters;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Characters",
              style: GoogleFonts.aBeeZee(
                  textStyle: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.w700))),
        ),
        body: FutureBuilder(
            future: getCharacters(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                throw Exception("Something wrong with the future builder");
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
                return ListView.builder(
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    Result character = characters[index];
                    return CharacterCard(character: character);
                  });
            }));
  }
}
