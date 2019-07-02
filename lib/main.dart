import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'home.dart';

final ThemeData _AppTheme = _buildAppTheme();

void main() {
  debugPaintSizeEnabled=true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      theme: _AppTheme,
    );
  }
}

ThemeData _buildAppTheme() {
  return ThemeData().copyWith(
    textTheme: ThemeData().textTheme.apply(fontFamily: 'Roboto'),
  );
}