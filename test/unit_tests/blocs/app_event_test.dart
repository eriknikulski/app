import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:nhie/blocs/app/app.dart';
import 'package:nhie/models/category.dart';
import 'package:nhie/models/category_name.dart';
import 'package:nhie/models/statement.dart';

void main() {
  List<Category> categories = [
    Category(
        name: CategoryName.harmless,
        selectedImageUri: 'assets/categories/mojito.svg',
        unselectedImageUri: 'assets/categories/mojito_gray.svg',
        selected: true),
    Category(
        name: CategoryName.delicate,
        selectedImageUri: 'assets/categories/beer.svg',
        unselectedImageUri: 'assets/categories/beer_gray.svg',
        selected: false),
    Category(
        name: CategoryName.offensive,
        selectedImageUri: 'assets/categories/cocktail.svg',
        unselectedImageUri: 'assets/categories/cocktail_gray.svg',
        selected: false),
  ];

  Statement statement = Statement(
    uuid: 'ec2a37e7-da79-44dc-b292-a5c343c0eaa8',
    text: 'Never have I ever forgotten to buy a present.',
    category: CategoryName.harmless,
  );

  Exception exception = SocketException('Bad status code');

  group('AppEvent', () {
    group('Initialize', () {
      test('toString returns correct value', () {
        expect(Initialize(categories).toString(),
            'Initialize { categories: $categories }');
      });

      test('props returns correct value', () {
        expect(Initialize(categories).props, [categories]);
      });
    });

    group('GoForward', () {
      test('toString returns correct value', () {
        expect(GoForward(categories).toString(),
            'GoForward { categories: $categories }');
      });

      test('props returns correct value', () {
        expect(GoForward(categories).props, [categories]);
      });
    });

    group('AddStatement', () {
      test('toString returns correct value', () {
        expect(AddStatement(statement).toString(),
            'AddStatement { statement: $statement }');
      });

      test('props returns correct value', () {
        expect(AddStatement(statement).props, [statement]);
      });
    });

    group('ChangeCategories', () {
      test('toString returns correct value', () {
        expect(ChangeCategories(categories).toString(),
            'ChangeCategories { categories: $categories }');
      });

      test('props returns correct value', () {
        expect(ChangeCategories(categories).props, [categories]);
      });
    });

    group('HandleException', () {
      test('toString returns correct value', () {
        expect(HandleException(exception).toString(),
            'HandleException { exception: $exception }');
      });

      test('props returns correct value', () {
        expect(HandleException(exception).props, [exception]);
      });
    });
  });
}
