import 'package:flutter/material.dart';

import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/screens/home/widgets/category_view.dart';

class CategoriesView extends StatelessWidget {
  /// Creates a row with the categories.
  ///
  /// The [categories] argument must not be null.
  CategoriesView({this.categories, this.height, this.categoryPictureWidth})
      : assert(categories != null &&
            height != null &&
            categoryPictureWidth != null);

  final List<Category> categories;
  final double height;
  final double categoryPictureWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: this
          .categories
          .map((category) => CategoryView(
                category: category,
                height: this.height,
                width: this.categoryPictureWidth,
              ))
          .toList(),
    );
  }
}
