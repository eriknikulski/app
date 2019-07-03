import 'dart:async';

import 'package:http/http.dart' as http;

import 'statement.dart';

const String url = 'https://api.neverhaveiever.io/v1';

Future<Statement> loadStatement({Map<String, Map<String, bool>> categories}) async {
  String param = categories.keys.map((category) => '$category=${categories[category]['selected']}').join('&');

  final response = await http.get('$url/statement?$param');
  return Statement.fromJson(response.body);
}
