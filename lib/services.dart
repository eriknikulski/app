import 'dart:async';

import 'package:http/http.dart' as http;

import 'statement.dart';

//const String url = 'http://192.168.178.45:5000/get/';
const String url = 'https://api.neverhaveiever.io/v1/statement';

Future<Statement> loadStatement() async {
  final response = await http.get('$url');
  return Statement.fromJson(response.body);
}
