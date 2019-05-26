import 'dart:async';

import 'package:flutter/material.dart';

import 'services.dart';
import 'statement.dart';
import 'statements_view.dart';

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => new HomePageState();
}

class HomePageState extends State<HomePage> {
  Future<List<Statement>> statements;

  @override
  void initState() {
    statements = loadStatements();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Never Have I Ever'),
      ),
      body: RaisedButton(
        child: Text('START'),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => FutureBuilder(
                      future: statements,
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                          case ConnectionState.waiting:
                          case ConnectionState.active:
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          case ConnectionState.done:
                            return StatementsView(
                              statements: snapshot.data,
                            );
                        }
                      },
                    )),
          );
        },
      ),
    );
  }
}
