import 'package:flutter/material.dart';

import 'package:never_have_i_ever/screens/statement_screen/statement_screen.dart';
import 'package:never_have_i_ever/theme/style.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Never Have I Ever',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => StatementScreen(),
      },
      theme: appTheme(),
    );
  }
}
