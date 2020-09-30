import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:nhie/blocs/app/app.dart';
import 'package:nhie/models/category_name.dart';
import 'package:nhie/models/statement.dart';

import '../../setup.dart';

void main() {
  defaultSetup();

  Statement statement = Statement(
    uuid: 'ec2a37e7-da79-44dc-b292-a5c343c0eaa8',
    text: 'Never have I ever forgotten to buy a present.',
    category: CategoryName.harmless,
  );

  Exception exception = SocketException('Bad status code');

  group('AppState', () {
    group('Uninitialized', () {
      test('toString returns correct value', () {
        expect(Uninitialized().toString(), 'Uninitialized');
      });

      test('props returns correct value', () {
        expect(Uninitialized().props, []);
      });
    });

    group('Initialized', () {
      test('toString returns correct value', () {
        expect(Initialized().toString(), 'Initialized');
      });

      test('props returns correct value', () {
        expect(Initialized().props, []);
      });
    });

    group('Forward', () {
      test('toString returns correct value', () {
        expect(
            Forward(statement).toString(), 'Forward { statement: $statement }');
      });

      test('props returns correct value', () {
        expect(Forward(statement).props, [statement]);
      });
    });

    group('AppException', () {
      test('toString returns correct value', () {
        expect(AppException(exception).toString(),
            'AppException { exception: $exception }');
      });

      test('props returns correct value', () {
        expect(AppException(exception).props, [exception]);
      });
    });
  });
}
