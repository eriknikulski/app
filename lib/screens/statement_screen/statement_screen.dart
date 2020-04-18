import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

import 'package:never_have_i_ever/blocs/app/app_bloc.dart';
import 'package:never_have_i_ever/blocs/statement/statement_bloc.dart';

import 'widgets/statement_container_view.dart';

class StatementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AppBloc(statementBloc: StatementBloc()),
        child: StatementContainerView(),
      ),
    );
  }
}
