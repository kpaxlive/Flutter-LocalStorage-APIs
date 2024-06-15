import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:task_3/models/color_model.dart';

class ViewContainer extends StatelessWidget {
  final Color color;
  final ColorModel colorData;
  const ViewContainer({super.key, required this.color, required this.colorData});

  @override
  Widget build(BuildContext context) {
    final double sHeight = MediaQuery.of(context).size.height;
    return Container(
                  margin: const EdgeInsets.only(top: 15),
                  padding: const EdgeInsets.all(15),
                  height: sHeight * 0.2,
                  decoration: BoxDecoration(
                      color: Colors.blue.shade50,
                      border: Border.all(width: 2, color: Colors.blue.shade100),
                      borderRadius: BorderRadius.circular(25)),
                  child: Row(
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        colorData.name!,
                        style: GoogleFonts.aBeeZee(
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(colorData.color!),
                    ],
                  ),
                );
  }
}