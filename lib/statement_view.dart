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
//            return Center(
//              child: CircularProgressIndicator(),
//            );
          case ConnectionState.done:
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: snapshot.data == null
                  ? CircularProgressIndicator()
                  : Text(
                      // TODO: sometimes error: The following NoSuchMethodError was thrown building FutureBuilder<Statement>(dirty, state:
                      //I/flutter ( 7407): _FutureBuilderState<Statement>#2fea5):
                      //I/flutter ( 7407): The getter 'text' was called on null.
                      //I/flutter ( 7407): Receiver: null
                      //I/flutter ( 7407): Tried calling: text
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
