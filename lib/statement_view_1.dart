import 'package:flutter/material.dart';

class StatementView extends StatelessWidget {
  StatementView({this.text}) : assert(text != null);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Never Have I Ever',
                    style: TextStyle(fontSize: 20.0, color: Colors.grey[600]),
                  ),
                  Text(
                    text.substring(18),
                    style: TextStyle(fontSize: 30.0),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
