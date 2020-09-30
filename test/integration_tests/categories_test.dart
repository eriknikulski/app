import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:nhie/blocs/app/app.dart';
import 'package:nhie/blocs/statement/statement.dart';
import 'package:nhie/models/category_name.dart';
import 'package:nhie/models/category.dart';
import 'package:nhie/screens/statement_screen/widgets/categories_view.dart';
import 'package:nhie/screens/statement_screen/widgets/category_view.dart';

import '../setup.dart';

main() async {
  await defaultSetup();

  final List<Category> categories = [
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
          home: BlocProvider(
            create: (context) => AppBloc(statementBloc: StatementBloc()),
            child: CategoriesView(
              categories: categories,
            ),
          ),
        ),
      );
      await tester.pumpWidget(categoriesView);

      expect(find.text('harmless'), findsOneWidget);
      expect(find.text('delicate'), findsOneWidget);
      expect(find.text('offensive'), findsOneWidget);

      var categoryFirst =
          find.byType(CategoryView).evaluate().first.widget as CategoryView;
      var categorySecond = find
          .byType(CategoryView)
          .evaluate()
          .elementAt(1)
          .widget as CategoryView;
      var categoryThird =
          find.byType(CategoryView).evaluate().last.widget as CategoryView;

      expect(categoryFirst.category.selected, isTrue);
      expect(categorySecond.category.selected, isFalse);
      expect(categoryThird.category.selected, isFalse);
    });

    testWidgets('select every category', (WidgetTester tester) async {
      Widget categoriesView = MediaQuery(
        data: MediaQueryData(),
        child: MaterialApp(
          home: BlocProvider(
            create: (context) => AppBloc(statementBloc: StatementBloc()),
            child: CategoriesView(
              categories: categories,
            ),
          ),
        ),
      );
      await tester.pumpWidget(categoriesView);

      var categoryFirst =
          find.byType(CategoryView).evaluate().first.widget as CategoryView;
      var categorySecond = find
          .byType(CategoryView)
          .evaluate()
          .elementAt(1)
          .widget as CategoryView;
      var categoryThird =
          find.byType(CategoryView).evaluate().last.widget as CategoryView;

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
          home: BlocProvider(
            create: (context) => AppBloc(statementBloc: StatementBloc()),
            child: CategoriesView(
              categories: categories,
            ),
          ),
        ),
      );
      await tester.pumpWidget(categoriesView);

      var categoryFirst =
          find.byType(CategoryView).evaluate().first.widget as CategoryView;
      var categorySecond = find
          .byType(CategoryView)
          .evaluate()
          .elementAt(1)
          .widget as CategoryView;
      var categoryThird =
          find.byType(CategoryView).evaluate().last.widget as CategoryView;

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
          home: BlocProvider(
            create: (context) => AppBloc(statementBloc: StatementBloc()),
            child: CategoriesView(
              categories: categories,
            ),
          ),
        ),
      );
      await tester.pumpWidget(categoriesView);

      var categoryFirst =
          find.byType(CategoryView).evaluate().first.widget as CategoryView;
      var categorySecond = find
          .byType(CategoryView)
          .evaluate()
          .elementAt(1)
          .widget as CategoryView;
      var categoryThird =
          find.byType(CategoryView).evaluate().last.widget as CategoryView;

      await tester.tap(find.byType(CategoryView).first);

      expect(categoryFirst.category.selected, isTrue);
      expect(categorySecond.category.selected, isTrue);
      expect(categoryThird.category.selected, isTrue);
    });
  });
}
