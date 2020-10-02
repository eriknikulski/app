import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nhie/blocs/app/app.dart';
import 'package:nhie/blocs/statement/statement.dart';
import 'package:nhie/theme/style.dart';
import 'package:nhie/screens/statement_screen/statement_screen.dart';

class App extends StatelessWidget {
  final AppBloc bloc;

  App({this.bloc});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Never Have I Ever',
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => BlocProvider(
              create: (context) =>
                  bloc ?? AppBloc(statementBloc: StatementBloc()),
              child: SafeArea(
                child: StatementScreen(),
              ),
            ),
      },
      theme: appTheme(),
    );
  }
}
