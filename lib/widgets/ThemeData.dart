import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chat_app/constants.dart';

ThemeData themeData = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: Color.fromARGB(255, 252, 252, 252),
  textTheme: TextTheme(
    bodyLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    titleMedium:
        TextStyle(fontSize: 14, fontWeight: FontWeight.w500, height: 1.4),
  ),
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: MainColor, //change your color here
      ),
      actionsIconTheme: IconThemeData(color: Colors.black),
      elevation: 0,
      backgroundColor: Color.fromARGB(255, 252, 252, 252),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      titleTextStyle: TextStyle(
          color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      titleSpacing: 20),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: MainColor,
      elevation: 30),
);
