import 'package:flutter/material.dart';

import 'package:never_have_i_ever/theme/colors.dart';

ThemeData appTheme() {
  final ThemeData base = ThemeData();
  return base.copyWith(
//    primaryColor: appBlue,
//    primaryColorLight: appBlueLight,
//    primaryColorDark: appBlueDark,
    textTheme: base.textTheme.apply(
        fontFamily: 'Roboto'
    ),
  );
}