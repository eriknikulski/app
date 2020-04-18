import 'package:flutter/material.dart'
    show ThemeData, TextTheme, TextStyle, Color, Colors;

ThemeData appTheme() {
  final ThemeData base = ThemeData();
  return base.copyWith(
    primaryColor: Colors.white,
    primaryTextTheme: TextTheme(
        title: TextStyle(
      color: Color(0xFF616161),
    )),
    textTheme: appTextTheme(base.textTheme),
  );
}

TextTheme appTextTheme(TextTheme base) {
  return base.copyWith(
    // Category title
    subhead: base.subhead.copyWith(
      fontSize: 16.0,
      color: Color(0xFF616161),
    ),
    // Statement
    display1: base.display1.copyWith(
      fontSize: 36.0,
      color: Color(0xFF424242),
    ),
  );
}
