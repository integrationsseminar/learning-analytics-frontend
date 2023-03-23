import 'package:flutter/material.dart';

//please add the colors you need for your views in this theme

ThemeData laappTheme() {
  return ThemeData(
    fontFamily: 'Raleway',

    // Colors
    backgroundColor: Colors.white,
    primaryColor: const Color(0xffE30613),
    primaryColorLight: const Color(0xffF54F59),
    accentColor: const Color(0xffD9D9D9),
    secondaryHeaderColor: const Color(0xfff0f0f0),
    splashColor: const Color.fromARGB(255, 142, 142, 142),

    highlightColor: Colors.grey[300],
    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xffF54F59),
          )),
    ),

    // Icons
    iconTheme: const IconThemeData(
      color: Color(0xffE30613),
    ),

    appBarTheme: const AppBarTheme(
      color: Color(0xffE30613),
    ),

    // Text Theme:
    // fontSizes comply to Material-Design guidelines
    textTheme: const TextTheme(
      // Headlines
      headlineLarge: TextStyle(
        fontSize: 30,
        fontFamily: 'Raleway',
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontSize: 20,
        fontFamily: 'Raleway',
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontSize: 13,
        fontFamily: 'Raleway',
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),

      // Title
      titleLarge: TextStyle(
        fontSize: 30,
        fontFamily: 'Raleway',
        color: Colors.black,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      titleMedium: TextStyle(
        fontSize: 20,
        fontFamily: 'Raleway',
        color: Colors.black,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      titleSmall: TextStyle(
        fontSize: 13,
        fontFamily: 'Raleway',
        color: Colors.black,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),

      // Labels
      labelLarge: TextStyle(
        fontSize: 30,
        fontFamily: 'Raleway',
        color: Color.fromARGB(255, 142, 142, 142),
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      labelMedium: TextStyle(
        fontSize: 20,
        fontFamily: 'Raleway',
        color: Color.fromARGB(255, 142, 142, 142),
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      labelSmall: TextStyle(
        fontSize: 13,
        fontFamily: 'Raleway',
        color: Color.fromARGB(255, 142, 142, 142),
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),

      // Body
      bodyLarge: TextStyle(
        fontSize: 30,
        fontFamily: 'Raleway',
        color: Color(0xffE30613),
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 20,
        fontFamily: 'Raleway',
        color: Color(0xffE30613),
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        fontFamily: 'Raleway',
        color: Color(0xffE30613),
        fontWeight: FontWeight.bold,
        letterSpacing: -0.5,
      ),
    ),
  );
}
