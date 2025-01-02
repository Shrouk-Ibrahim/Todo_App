import 'package:flutter/material.dart';

class MyTheme {
  static Color primaryLight = Color(0xff5D9CEC);
  static Color backGroundLight = Color(0xffDFECDB);
  static Color greenColor = Color(0xff61E757);
  static Color redColor = Color(0xffEC4B4B);
  static Color blackColor = Color(0xff303030);
  static Color whiteColor = Color(0xffffffff);
  static Color greyColor = Color(0xff737375);
  static Color backGroundDark = Color(0xff060E1E);
  static Color blackDark = Color(0xff141922);
  static ThemeData LightTheme = ThemeData(
      scaffoldBackgroundColor: backGroundLight,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryLight, unselectedItemColor: greyColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryLight, shape: StadiumBorder(
        side: BorderSide(
          color:whiteColor ,
          width :4
        )
      )),
      appBarTheme: AppBarTheme(backgroundColor: primaryLight, elevation: 0),
      textTheme: TextTheme(
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        titleMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
        color: blackColor),
        titleSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,
            color: blackColor),
      ));
}
