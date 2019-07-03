import 'package:flutter/material.dart';

import 'category.dart';
import 'category_view.dart';

class CategoriesView extends StatefulWidget {
  /// Creates a row with the categories.
  ///
  /// The [data] argument must not be null.
  CategoriesView({this.data, this.height, this.elementWidth})
      : assert(data != null && height != null && elementWidth != null);

  final List<Category> data;
  final double height;
  final double elementWidth;

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  handleCategoryChange(Category category) {
    // TODO: check that not all unselected
    setState(() => category.selected = !category.selected);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: this
          .widget
          .data
          .map((category) => CategoryView(
                category: category,
                height: this.widget.height,
                width: this.widget.elementWidth,
                handleCategoryChange: handleCategoryChange,
              ))
          .toList(),
    );
  }
}
