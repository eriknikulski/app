import 'dart:io' show SocketException;

import 'package:flutter/foundation.dart' show describeEnum;
import 'package:http/http.dart' as http show Client;
import 'package:uuid/uuid.dart';

import 'package:nhie/env.dart';
import 'package:nhie/models/category.dart';
import 'package:nhie/models/statement.dart';

class StatementApiProvider {
  static final baseUrl = env.baseUrl;
  static final uuid = Uuid().v4();
  static http.Client client = http.Client();

  /// Returns `Future<Statement>` from [baseUrl] based on [categories].
  ///
  /// If [categories] is not provided correctly an `ArgumentError` is thrown.
  /// If no `Category` in [categories] is selected an `AssertionError` is thrown.
  /// If the response status code is any other than 200 a `SocketException` is thrown
  /// with the message 'Bad status code'.
  static Future<Statement> fetchStatement(List<Category> categories) async {
    if (categories.isEmpty || categories is! List<Category>) {
      throw ArgumentError('No valid argument');
    }
    assert(!categories.every((category) => !category.selected),
        'No category selected');

    String params = categories
        .map((category) => category.selected
            ? 'category[]=${describeEnum(category.name)}'
            : null)
        .where((element) => element != null)
        .join('&')
        + '&game_id=$uuid';

    final response = await client.get('$baseUrl/statements/random?$params');

    if (response.statusCode == 200) {
      return Statement.fromJson(response.body);
    } else {
      throw SocketException('Bad status code');
    }
  }
}
