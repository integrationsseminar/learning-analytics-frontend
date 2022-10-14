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

    highlightColor: Colors.grey[300],
    // Buttons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
        const Color(0xffE30613),
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
        fontSize: 36,
        fontFamily: 'Raleway Bold',
        color: Color(0xffE30613),
        letterSpacing: -0.5,
      ),
      headlineMedium: TextStyle(
        fontSize: 22,
        fontFamily: 'Raleway Bold',
        color: Color(0xffE30613),
        letterSpacing: -0.5,
      ),
      headlineSmall: TextStyle(
        fontSize: 16,
        fontFamily: 'Raleway Bold',
        color: Color(0xffE30613),
        letterSpacing: -0.5,
      ),

      // Title
      titleLarge: TextStyle(
        fontSize: 20,
        fontFamily: 'Raleway Bold',
        color: Color(0xffE30613),
        letterSpacing: -0.5,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontFamily: 'Raleway Bold',
        color: Color(0xffE30613),
        letterSpacing: -0.5,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontFamily: 'Raleway Bold',
        color: Color(0xffE30613),
        letterSpacing: -0.5,
      ),

      // Labels
      labelLarge: TextStyle(
        fontSize: 20,
        fontFamily: 'Raleway',
        color: Colors.white,
        letterSpacing: -0.5,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontFamily: 'Raleway',
        color: Colors.white,
        letterSpacing: -0.5,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontFamily: 'Raleway',
        color: Colors.white,
        letterSpacing: -0.5,
      ),

      // Body
      bodyLarge: TextStyle(
        fontSize: 20,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.w900,
        color: Colors.black,
        letterSpacing: -0.5,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontFamily: 'Raleway',
        fontWeight: FontWeight.bold,
        color: Colors.black,
        letterSpacing: -0.5,
      ),
      bodySmall: TextStyle(
        fontSize: 12,
        fontFamily: 'Raleway',
        color: Colors.black,
        letterSpacing: -0.5,
      ),
    ),
  );
}
