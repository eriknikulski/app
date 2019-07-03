import 'dart:async';

import 'package:flutter/material.dart';

import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/statement.dart';
import 'package:never_have_i_ever/screens/home/widgets/categories_view.dart';
import 'package:never_have_i_ever/screens/home/widgets/statement_view.dart';
import 'package:never_have_i_ever/services/services.dart';

class StatementContainerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatementContainerViewState();
}

class _StatementContainerViewState extends State<StatementContainerView> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  // TODO: hardcoded date eventuell auslagern auch siehe svgHeight, svgWidth

  final List<Category> categories = [
    Category(
        name: 'harmless',
        selectedImageUri: 'images/mojito.svg',
        unselectedImageUri: 'images/mojito_gray.svg',
        selected: true),
    Category(
        name: 'delicate',
        selectedImageUri: 'images/beer.svg',
        unselectedImageUri: 'images/beer_gray.svg',
        selected: false),
    Category(
        name: 'offensive',
        selectedImageUri: 'images/cocktail.svg',
        unselectedImageUri: 'images/cocktail_gray.svg',
        selected: false),
  ];

  Future<Statement> _statement;

  Widget categorySelection(context) {
    double svgHeight = MediaQuery.of(context).size.height * 0.16 > 72
        ? 72
        : MediaQuery.of(context).size.height * 0.16;
    double svgWidth = 65;

    return CategoriesView(
      categories: categories,
      height: svgHeight,
      categoryPictureWidth: svgWidth,
    );
  }

  @override
  void initState() {
    super.initState();
    _statement = loadStatement(categories: categories);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _statement = loadStatement(categories: categories);
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    categorySelection(context),
                    StatementView(
                      futureText: _statement,
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
