import 'package:flutter/material.dart';

import 'category_view.dart';

class CategoriesView extends StatefulWidget {
  /// Creates a row with the categories.
  ///
  /// The [data] argument must not be null.
  /// [data] must be in form of:
  /// {
  ///   'category1': {
  ///     'images': {true: 'image_for_selected', false: 'image_for_unselected},
  ///     'selected': true/false,
  ///   },
  ///   'category2': {
  ///     ...
  ///   },
  ///   ...
  /// }
  ///
  /// For example:
  /// {
  ///   'harmless': {
  ///     'images': {true: 'images/mojito.svg', false: 'images/mojito_gray.svg'},
  ///     'selected': true
  ///   },
  ///   'delicate': {
  ///     'images': {true: 'images/beer.svg', false: 'images/beer_gray.svg'},
  ///     'selected': false
  ///   },
  ///   'offensive': {
  ///     'images': {
  ///       true: 'images/cocktail.svg',
  ///       false: 'images/cocktail_gray.svg'
  ///     },
  ///     'selected': false
  ///   },
  /// }
  CategoriesView(
      {this.data, this.height, this.elementWidth, this.categorySelectionChange})
      : assert(data != null &&
            height != null &&
            elementWidth != null &&
            categorySelectionChange != null);

  final Map<String, Map<String, dynamic>> data;
  final double height;
  final double elementWidth;
  final Function categorySelectionChange;

  @override
  _CategoriesViewState createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  Map<String, Map<String, bool>> categories = Map();

  handleCategoryChange(category) {
    var copiedCategories = Map.from(categories);
    copiedCategories.remove(category);
    print('mulm');

    if (categories[category]['selected'] && copiedCategories.values.every((category) => category['selected'])) {
      print('all would be unselected');
      print(categories);
    }

    setState(() =>
        categories[category]['selected'] = !categories[category]['selected']);
    widget.categorySelectionChange(category);
  }

  @override
  void initState() {
    super.initState();
    widget.data.keys.forEach((category) => setState(() => categories[category] =
        {'selected': widget.data[category]['selected']}));
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: this
          .widget
          .data
          .keys
          .map((category) => CategoryView(
                name: category,
                selected: categories[category]['selected'],
                selectedImageUri: this.widget.data[category]['images'][true],
                unselectedImageUri: this.widget.data[category]['images'][false],
                height: this.widget.height,
                width: this.widget.elementWidth,
                handleCategoryChange: handleCategoryChange,
              ))
          .toList(),
    );
  }
}
