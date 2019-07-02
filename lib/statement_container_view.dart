import 'dart:async';

import 'package:flutter/material.dart';

import 'services.dart';
import 'statement.dart';
import 'statement_view_2.dart';

class StatementContainerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatementContainerViewState();
}

class _StatementContainerViewState extends State<StatementContainerView> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  Future<Statement> _statement;

  Widget _buildStatement(Statement statement) {
    return GestureDetector(
      key: Key(statement.text),
      onTap: () {
        setState(() {
          _statement = loadStatement();
        });
      },
      child: StatementView(
        text: statement.text,
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _statement = loadStatement();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _statement,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            return _buildStatement(snapshot.data);
        }
      },
    );
  }
}
