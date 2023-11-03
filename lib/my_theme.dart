import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLight = Color(0xff5D9CEC);
  static Color bgLight = Color(0xffDFECDB);
  static Color bgDark = Color(0xff060E1E);
  static Color green = Color(0xff61E757);
  static Color red = Color(0xffEC4B4B);
  static Color grey = Color(0xffC8C9CB);
  static Color darkgrey = Color(0xff363636);
  static Color black = Color(0xff141922);
  static Color white = Color(0xffFFFFFF);

  static ThemeData LightTheme = ThemeData(
      primaryColor: primaryLight,
      scaffoldBackgroundColor: bgLight,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryLight,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: Colors.transparent,
          unselectedItemColor: grey,
          selectedItemColor: primaryLight),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryLight,
          shape: StadiumBorder(side: BorderSide(color: white, width: 4))),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: white,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: black,
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: black,
        ),
      ));

  static ThemeData DarkTheme = ThemeData(
      primaryColor: primaryLight,
      scaffoldBackgroundColor: bgDark,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryLight,
        elevation: 0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: Colors.transparent,
          unselectedItemColor: white,
          selectedItemColor: primaryLight),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryLight,
          shape: StadiumBorder(side: BorderSide(color: darkgrey, width: 4))),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: white,
        ),
        titleMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: white,
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: white,
        ),
      ));
}
