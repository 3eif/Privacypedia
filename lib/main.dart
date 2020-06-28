import 'screens/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MaterialApp(
    title: 'TOS Summary',
    theme: ThemeData(
      textTheme: GoogleFonts.robotoTextTheme(),
    ),
    home: HomePage(),
  ));
}
