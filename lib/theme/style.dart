import 'package:flutter/material.dart';

ThemeData appTheme() {
  return ThemeData().copyWith(
    textTheme: ThemeData().textTheme.apply(fontFamily: 'Roboto'),
  );
}