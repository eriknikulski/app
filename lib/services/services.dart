import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/statement.dart';

Future<Statement> loadStatement({List<Category> categories}) async {
  if (categories.every((category) => !category.selected)) {
    return Statement(text: 'Please select a category to continue ;)');
  }

  String param = categories
      .map((category) => '${category.name}=${category.selected}')
      .join('&');

  final response =
      await http.get('https://api.neverhaveiever.io/v1/statement?$param');
  return Statement.fromJson(response.body);
}
