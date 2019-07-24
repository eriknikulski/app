import 'package:flutter_test/flutter_test.dart';

import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/category_icon.dart';

import '../setup.dart';

main() {
  defaultSetup();

  group('test category icon object', () {
    test('right attributes', () {
      CategoryIcon categoryIcon = CategoryIcon(
          name: Category.harmless,
          selectedImageUri: 'dummy_selected.png',
          unselectedImageUri: 'dummy_unselected.png',
          selected: false);

      assert(categoryIcon.name == Category.harmless);
      assert(categoryIcon.selectedImageUri == 'dummy_selected.png');
      assert(categoryIcon.unselectedImageUri == 'dummy_unselected.png');
      assert(categoryIcon.selected == false);
    });

    test('category icon toString', () {
      CategoryIcon categoryIcon = CategoryIcon(
          name: Category.harmless,
          selectedImageUri: 'dummy_selected.png',
          unselectedImageUri: 'dummy_unselected.png',
          selected: false);

      assert(categoryIcon.toString() == 'Category: {'
          'name: Category.harmless, '
          'selectedImageUri: dummy_selected.png, '
          'unselectedImageUri: dummy_unselected.png, '
          'selected: false'
          '}');
    });
  });
}
