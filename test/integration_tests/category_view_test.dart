import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/category_icon.dart';
import 'package:never_have_i_ever/screens/statement_screen/widgets/category_view.dart';

main() {
  final category = CategoryIcon(
      name: Category.harmless,
      selectedImageUri: 'images/mojito.png',
      unselectedImageUri: 'images/mojito_gray.png',
      selected: true);

  group('category view widget', () {
    testWidgets('check assertion', (WidgetTester tester) async {
      expect(() {
        MediaQuery(
            data: MediaQueryData(),
            child: MaterialApp(
              home: CategoryView(
                category: null,
                selectionStateChanged: null,
              ),
            ));
      }, throwsAssertionError);
    });

    testWidgets('inital state', (WidgetTester tester) async {
      Widget categoryView = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
            home: CategoryView(
              category: category,
              selectionStateChanged: () {},
            ),
          ));
      await tester.pumpWidget(categoryView);
      expect(find.text('harmless'), findsOneWidget);
    });

    testWidgets('change selection', (WidgetTester tester) async {
      Widget categoryView = MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
            home: CategoryView(
              category: category,
              selectionStateChanged: () {},
            ),
          ));
      await tester.pumpWidget(categoryView);
      var categoryObject = find.byType(CategoryView).evaluate().first.widget as CategoryView;

      expect(categoryObject.category.selected, isTrue);
      await tester.tap(find.byType(CategoryView).first);
      expect(categoryObject.category.selected, isFalse);
    });
  });
}
