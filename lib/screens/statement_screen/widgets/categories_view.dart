import 'package:flutter/material.dart';

import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/screens/statement_screen/widgets/category_view.dart';

class CategoriesView extends StatelessWidget {
  /// Creates a row with the categories.
  ///
  /// The [categories] argument must not be null.
  CategoriesView({this.categories}) : assert(categories != null);

  final List<Category> categories;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: categories
          .map((category) => CategoryView(
                category: category,
              ))
          .toList(),
    );
  }
}
