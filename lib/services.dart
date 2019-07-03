import 'dart:async';

import 'package:http/http.dart' as http;

import 'category.dart';
import 'statement.dart';

const String url = 'https://api.neverhaveiever.io/v1';

Future<Statement> loadStatement({List<Category> categories}) async {
  String param = categories
      .map((category) => '${category.name}=${category.selected}')
      .join('&');

  final response = await http.get('$url/statement?$param');
  return Statement.fromJson(response.body);
}
