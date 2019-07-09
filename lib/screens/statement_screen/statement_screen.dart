import 'package:flutter/material.dart';

import 'package:never_have_i_ever/screens/statement_screen/widgets/statement_container_view.dart';

class StatementScreen extends StatelessWidget {
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
