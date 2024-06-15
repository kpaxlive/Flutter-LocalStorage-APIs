import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_1/models/character_model.dart';

class CharacterCard extends StatelessWidget {
  final Result character;
  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Container(
        padding: const EdgeInsets.all(15),
        height: 350,
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          border: Border.all(
              width: 1, color: const Color.fromARGB(255, 108, 179, 238)),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(character.image!),
                minRadius: 75,
                maxRadius: 75,
              ),
            ),
            Center(
              child: Text(
                character.name!,
                style: GoogleFonts.aBeeZee(
                  textStyle: const TextStyle(
                      fontSize: 25, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                character.status == Status.ALIVE
                    ? Text("Status: Alive",
                        style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ))
                    : Text("Status: Dead",
                        style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        )),
                character.species == Species.HUMAN
                    ? Text("Species: Human",
                        style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ))
                    : Text("Species: Alien",
                        style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        )),
                Text('Origin: ${character.origin!.name!}',
                    style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    )),
                Text('Location: ${character.location!.name!}',
                    style: GoogleFonts.aBeeZee(
                      textStyle: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.w500),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
