import 'dart:async';

import 'package:http/http.dart' as http;

import 'package:never_have_i_ever/env.dart';
import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/statement.dart';

class StatementApiProvider {
  static final baseUrl = env.baseUrl;

  /// Returns `Future<Statement>` from [baseUrl] based on [categories].
  ///
  /// If no `Category` in [categories] is selected this method returns a `Statement` with text: 'Please select a category to continue'.
  /// If the response status code is not 200 this method returns `null`.
  static Future<Statement> fetchStatement(List<Category> categories) async {
    if (categories.every((category) => !category.selected)) {
      return Statement(text: 'Please select a category to continue');
    }

    String params = categories
        .map((category) => category.selected ? 'category[]=${category.name}' : null)
        .where((element) => element != null)
        .join('&');

    print('$baseUrl/statements/random?$params');

    final response =
        await http.get('$baseUrl/statements/random?$params');

    if (response.statusCode == 200) {
      return Statement.fromJson(response.body);
    } else {
      return null;
    }
  }
}
