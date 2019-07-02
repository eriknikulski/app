import 'package:flutter/material.dart';

import 'statement_container_view.dart';

class HomePage extends StatelessWidget {
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Never Have I Ever'),
      ),
      body: StatementContainerView(),
    );
  }
}
