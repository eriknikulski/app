import 'package:flutter/material.dart';

ThemeData appTheme() {
  final ThemeData base = ThemeData();
  return base.copyWith(
    textTheme: base.textTheme.apply(fontFamily: 'Roboto'),
  );
}
