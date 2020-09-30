import 'package:flutter_test/flutter_test.dart';

import 'package:nhie/models/category_name.dart';
import 'package:nhie/models/category.dart';

import '../setup.dart';

main() async {
  await defaultSetup();

  group('test category icon object', () {
    test('right attributes', () {
      Category category = Category(
          name: CategoryName.harmless,
          selectedImageUri: 'dummy_selected.svg',
          unselectedImageUri: 'dummy_unselected.svg',
          selected: false);

      assert(category.name == CategoryName.harmless);
      assert(category.selectedImageUri == 'dummy_selected.svg');
      assert(category.unselectedImageUri == 'dummy_unselected.svg');
      assert(category.selected == false);
    });

    test('category icon toString', () {
      Category category = Category(
          name: CategoryName.harmless,
          selectedImageUri: 'dummy_selected.svg',
          unselectedImageUri: 'dummy_unselected.svg',
          selected: false);

      assert(category.toString() ==
          'Category { '
              'name: CategoryName.harmless, '
              'selectedImageUri: dummy_selected.svg, '
              'unselectedImageUri: dummy_unselected.svg, '
              'selected: false'
              ' }');
    });
  });
}
