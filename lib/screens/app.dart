import 'package:flutter/material.dart';

import 'package:never_have_i_ever/blocs/app/app_bloc.dart';
import 'package:never_have_i_ever/theme/style.dart';

import 'statement_screen/statement_screen.dart';

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
