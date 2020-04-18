import 'package:flutter/material.dart';

import 'package:never_have_i_ever/models/category.dart';

import 'category_view.dart';

class CategoriesView extends StatefulWidget {
  /// Creates a row with the categories.
  ///
  /// The [categories] argument must not be null.
  CategoriesView({this.categories}) : assert(categories != null);

  final List<Category> categories;

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  selectionStateChanged() {
    if (widget.categories.every((category) => !category.selected)) {
      setState(() {
        widget.categories.forEach((category) => category.selected = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.categories
          .map((category) => CategoryView(
                category: category,
                selectionStateChanged: selectionStateChanged,
              ))
          .toList(),
    );
  }
}
