import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:nhie/blocs/statement/statement.dart';
import 'package:nhie/models/category_name.dart';
import 'package:nhie/models/statement.dart';

void main() {
  Statement statement = Statement(
    uuid: 'ec2a37e7-da79-44dc-b292-a5c343c0eaa8',
    text: 'Never have I ever forgotten to buy a present.',
    category: CategoryName.harmless,
  );

  Exception exception = SocketException('Bad status code');

  group('StatementState', () {
    group('StatementLoading', () {
      test('toString returns correct value', () {
        expect(StatementLoading().toString(), 'StatementLoading');
      });

      test('props returns correct value', () {
        expect(StatementLoading().props, []);
      });
    });

    group('StatementLoaded', () {
      test('toString returns correct value', () {
        expect(StatementLoaded(statement).toString(),
            'StatementLoaded { statement: $statement }');
      });

      test('props returns correct value', () {
        expect(StatementLoaded(statement).props, [statement]);
      });
    });

    group('StatementNotLoaded', () {
      test('toString returns correct value', () {
        expect(StatementNotLoaded(exception).toString(),
            'StatementNotLoaded { exception: $exception }');
      });

      test('props returns correct value', () {
        expect(StatementNotLoaded(exception).props, [exception]);
      });
    });
  });
}
