import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

import 'package:nhie/blocs/app/app.dart';
import 'package:nhie/models/category.dart';
import 'package:nhie/screens/statement_screen/widgets/category_view.dart';

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
    BlocProvider.of<AppBloc>(context).add(ChangeCategories(widget.categories));
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
