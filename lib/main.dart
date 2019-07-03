import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:never_have_i_ever/screens/home/home.dart';
import 'package:never_have_i_ever/theme/style.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: HomePage(),
      theme: appTheme(),
    );
  }
}
