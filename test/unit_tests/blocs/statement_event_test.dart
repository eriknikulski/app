import 'package:flutter_test/flutter_test.dart';
import 'package:nhie/blocs/statement/statement.dart';
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

  group('StatementEvent', () {
    group('LoadStatement', () {
      group('toString returns correct value', () {
        test('only categories', () {
          expect(LoadStatement(categories: categories).toString(),
              'LoadStatement { categories: $categories, statement: null }');
        });

        test('only statement', () {
          expect(LoadStatement(statement: statement).toString(),
              'LoadStatement { categories: null, statement: $statement }');
        });

        test('only categories', () {
          expect(
              LoadStatement(categories: categories, statement: statement)
                  .toString(),
              'LoadStatement { categories: $categories, statement: $statement }');
        });
      });

      group('props returns correct value', () {
        test('only categories', () {
          expect(
              LoadStatement(categories: categories).props, [categories, null]);
        });

        test('only statement', () {
          expect(LoadStatement(statement: statement).props, [null, statement]);
        });

        test('categories and statement', () {
          expect(
              LoadStatement(categories: categories, statement: statement).props,
              [categories, statement]);
        });
      });
    });
  });
}
