import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

import 'package:nhie/blocs/app/app.dart';
import 'package:nhie/blocs/statement/statement.dart';
import 'package:nhie/screens/statement_screen/widgets/statement_container_view.dart';

class StatementScreen extends StatelessWidget {
  final AppBloc bloc;

  StatementScreen({ this.bloc });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => bloc ?? AppBloc(statementBloc: StatementBloc()),
        child: StatementContainerView(),
      ),
    );
  }
}
