import 'package:flutter/material.dart';

import 'package:nhie/blocs/app/app.dart';
import 'package:nhie/theme/style.dart';
import 'package:nhie/screens/statement_screen/statement_screen.dart';

class App extends StatelessWidget {
  final AppBloc bloc;

  App({ this.bloc });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Never Have I Ever',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => StatementScreen(bloc: bloc),
      },
      theme: appTheme(),
    );
  }
}
