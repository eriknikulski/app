import 'package:flutter/material.dart';

import 'statement.dart';

class StatementView extends StatelessWidget {
  StatementView({this.futureText}) : assert(futureText != null);

  final Future<Statement> futureText;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this.futureText,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
          case ConnectionState.done:
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: snapshot.data == null
                  ? CircularProgressIndicator()
                  : Text(
                      snapshot.data.text,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 36.0, color: Color(0xFF424242)),
                    ),
            );
        }
      },
    );
  }
}
