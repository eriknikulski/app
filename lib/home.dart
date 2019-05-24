import 'dart:async';

// import 'services.dart';

import 'package:flutter/material.dart';
import 'statement.dart';

import 'statements_view.dart';
import 'package:http/http.dart' as http;

const String url =
    'https://deac2a8c-9d50-491e-978e-dc493af441db.mock.pstmn.io/get';

Future<Statement> getStatement(int i) async {
  final response = await http.get('$url/$i');
  return Statement.fromJson(response.body);
}

// const statement_texts = ['click this nice text'];
const List<String> statement_texts = [];

final statements =
    statement_texts.map((text) => Statement(text: text)).toList();

class HomePage extends StatelessWidget {
  buildStatements() async {
    List<int>.generate(16, (i) => i)
        .forEach((i) => getStatement(i).then((statement) {
              statements.add(statement);
              print(i);
            }));
  }

  @override
  Widget build(BuildContext context) {
    buildStatements();

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
                builder: (BuildContext context) => StatementsView(
                      statements: statements,
                    )),
          );
        },
      ),
    );
  }
}
