import 'package:http/http.dart' as http;
import 'dart:async';

import 'statement.dart';

const String url =
    'https://deac2a8c-9d50-491e-978e-dc493af441db.mock.pstmn.io/get';

Future<Statement> getStatement(int i) async {
  final response = await http.get('$url/$i');
  return Statement.fromJson(response.body);
}
