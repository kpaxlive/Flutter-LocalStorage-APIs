import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_4/components/my_textfield.dart';
import 'package:task_4/models/user_model.dart';
import 'package:task_4/screens/second_page.dart';
import 'package:task_4/services/database_service.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();

  final TextEditingController surnameController = TextEditingController();

  final TextEditingController ageController = TextEditingController();

  final TextEditingController mailController = TextEditingController();

  final TextEditingController colorController = TextEditingController();

  late final DatabaseService db;

  @override
  void initState() {
    super.initState();
    db = DatabaseService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade900,
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SecondPage(),
            )),
        child: Icon(
          Icons.arrow_circle_right_outlined,
          color: Colors.grey.shade200,
          size: 40,
        ),
      ),
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Your Details",
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade800),
              ),
            ),
            const SizedBox(
              height: 35,
            ),
            MyTextfield(
              controller: nameController,
              labelText: 'Name',
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextfield(
              controller: surnameController,
              labelText: 'Surname',
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextfield(
              controller: ageController,
              labelText: 'Age',
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextfield(
              controller: mailController,
              labelText: 'Email',
            ),
            const SizedBox(
              height: 20,
            ),
            MyTextfield(
              controller: colorController,
              labelText: 'Favorite Color',
            ),
            const SizedBox(
              height: 25,
            ),
            GestureDetector(
              onTap: () async {
                String name = nameController.text;
                String surname = surnameController.text;
                String age = ageController.text;
                String mail = mailController.text;
                String color = colorController.text;
                if (checkInputs(name, surname, age, mail, color)) {
                  UserData user = UserData(
                      name: nameController.text,
                      surname: surnameController.text,
                      age: int.tryParse(ageController.text),
                      mail: mailController.text,
                      favoriteColor: colorController.text);
                  await db.insertItem(user);
                  // ignore: invalid_use_of_protected_member
                  (context as Element).reassemble();
                  List<UserData> users = await db.getItems();
                  users.forEach((element) {
                    print(
                        '${element.name}, ${element.surname}, ${element.age}');
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Data saved succesfuly")));
                }
              },
              child: Container(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.shade900,
                ),
                child: Center(
                    child: Text(
                  "Save",
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                        color: Colors.grey.shade200,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                )),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  bool checkInputs(
      String name, String surname, String age, String mail, String color) {
    if (name.isEmpty ||
        surname.isEmpty ||
        age.isEmpty ||
        mail.isEmpty ||
        color.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Couldn't save data cause of empty fields")));

      return false;
    } else if (int.tryParse(age) == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Only numbers are allowed in age field")));
      return false;
    }
    return true;
  }
}
