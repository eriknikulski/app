import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/category_icon.dart';
import 'package:never_have_i_ever/screens/statement_screen/widgets/categories_view.dart';
import 'package:never_have_i_ever/screens/statement_screen/widgets/category_view.dart';

import '../setup.dart';

main() {
  defaultSetup();

  final List<CategoryIcon> categories = [
    CategoryIcon(
        name: Category.harmless,
        selectedImageUri: 'images/mojito.png',
        unselectedImageUri: 'images/mojito_gray.png',
        selected: true),
    CategoryIcon(
        name: Category.delicate,
        selectedImageUri: 'images/beer.png',
        unselectedImageUri: 'images/beer_gray.png',
        selected: false),
    CategoryIcon(
        name: Category.offensive,
        selectedImageUri: 'images/cocktail.png',
        unselectedImageUri: 'images/cocktail_gray.png',
        selected: false),
  ];

  resetCategorySelection() {
    categories.forEach((category) => category.selected = false);
    categories.first.selected = true;
  }

  setUp(() {
    resetCategorySelection();
  });

  group('categories view widget', () {
    testWidgets('initial categories state', (WidgetTester tester) async {
      Widget categoriesView = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: CategoriesView(
            categories: categories,
          ),
        ),
      );
      await tester.pumpWidget(categoriesView);

      expect(find.text('harmless'), findsOneWidget);
      expect(find.text('delicate'), findsOneWidget);
      expect(find.text('offensive'), findsOneWidget);

      var categoryFirst = find.byType(CategoryView).evaluate().first.widget as CategoryView;
      var categorySecond = find.byType(CategoryView).evaluate().elementAt(1).widget as CategoryView;
      var categoryThird = find.byType(CategoryView).evaluate().last.widget as CategoryView;

      expect(categoryFirst.category.selected, isTrue);
      expect(categorySecond.category.selected, isFalse);
      expect(categoryThird.category.selected, isFalse);
    });

    testWidgets('select every category', (WidgetTester tester) async {
      Widget categoriesView = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: CategoriesView(
            categories: categories,
          ),
        ),
      );
      await tester.pumpWidget(categoriesView);

      var categoryFirst = find.byType(CategoryView).evaluate().first.widget as CategoryView;
      var categorySecond = find.byType(CategoryView).evaluate().elementAt(1).widget as CategoryView;
      var categoryThird = find.byType(CategoryView).evaluate().last.widget as CategoryView;

      await tester.tap(find.byType(CategoryView).at(1));
      await tester.tap(find.byType(CategoryView).last);

      expect(categoryFirst.category.selected, isTrue);
      expect(categorySecond.category.selected, isTrue);
      expect(categoryThird.category.selected, isTrue);
    });

    testWidgets('select only last category', (WidgetTester tester) async {
      Widget categoriesView = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: CategoriesView(
            categories: categories,
          ),
        ),
      );
      await tester.pumpWidget(categoriesView);

      var categoryFirst = find.byType(CategoryView).evaluate().first.widget as CategoryView;
      var categorySecond = find.byType(CategoryView).evaluate().elementAt(1).widget as CategoryView;
      var categoryThird = find.byType(CategoryView).evaluate().last.widget as CategoryView;

      await tester.tap(find.byType(CategoryView).last);
      await tester.tap(find.byType(CategoryView).first);

      expect(categoryFirst.category.selected, isFalse);
      expect(categorySecond.category.selected, isFalse);
      expect(categoryThird.category.selected, isTrue);
    });

    testWidgets('unselect every category', (WidgetTester tester) async {
      Widget categoriesView = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: CategoriesView(
            categories: categories,
          ),
        ),
      );
      await tester.pumpWidget(categoriesView);

      var categoryFirst = find.byType(CategoryView).evaluate().first.widget as CategoryView;
      var categorySecond = find.byType(CategoryView).evaluate().elementAt(1).widget as CategoryView;
      var categoryThird = find.byType(CategoryView).evaluate().last.widget as CategoryView;

      await tester.tap(find.byType(CategoryView).first);

      expect(categoryFirst.category.selected, isTrue);
      expect(categorySecond.category.selected, isTrue);
      expect(categoryThird.category.selected, isTrue);
    });
  });
}
