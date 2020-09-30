import 'package:flutter_test/flutter_test.dart';
import 'package:nhie/blocs/statement/statement.dart';
import 'package:nhie/models/category.dart';
import 'package:nhie/models/category_name.dart';

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

  group('StatementEvent', () {
    group('LoadStatement', () {
      test('toString returns correct value', () {
        expect(LoadStatement(categories).toString(),
            'LoadStatement { categories: $categories }');
      });
    });
  });
}
