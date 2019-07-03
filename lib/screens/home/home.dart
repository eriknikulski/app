import 'package:flutter/material.dart';

import 'package:never_have_i_ever/screens/home/widgets/statement_container_view.dart';

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
