import 'package:flutter/material.dart';
import 'package:task_3/components/view_container.dart';
import 'package:task_3/models/color_model.dart';
import 'package:task_3/screens/second_page.dart';
import 'package:task_3/services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService api = ApiService();
  List<ColorModel> colors = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<ColorModel>> getDatas() async {
    try {
      colors = await api.getData();
      return colors;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.arrow_circle_right_outlined,
          size: 40,
        ),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const PostMethod(),
          ),
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(right: 15, left: 15, bottom: 25),
        child: FutureBuilder(
          future: getDatas(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            }

            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final colorData = snapshot.data![index];
                final String color = snapshot.data![index].color!;
                final String colorSub = color.substring(1);
                final String colorUnion = '0xff$colorSub';
                Color circle = Color(int.parse(colorUnion));
                return ViewContainer(colorData: colorData, color: circle);
              },
            );
          },
        ),
      ),
    );
  }
}
