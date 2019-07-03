import 'dart:async';

import 'package:flutter/material.dart';

import 'category.dart';
import 'categories_view.dart';
import 'services.dart';
import 'statement.dart';
import 'statement_view.dart';

class StatementContainerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatementContainerViewState();
}

class _StatementContainerViewState extends State<StatementContainerView> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  // TODO: hardcoded date eventuell auslagern auch siehe svgHeight, svgWidth
  final Map<String, Map<String, dynamic>> svgData = {
    'harmless': {
      'images': {true: 'images/mojito.svg', false: 'images/mojito_gray.svg'},
      'selected': true
    },
    'delicate': {
      'images': {true: 'images/beer.svg', false: 'images/beer_gray.svg'},
      'selected': false
    },
    'offensive': {
      'images': {
        true: 'images/cocktail.svg',
        false: 'images/cocktail_gray.svg'
      },
      'selected': false
    },
  };

  Future<Statement> _statement;
  Map<String, Map<String, bool>> categories = {
    'harmless': {
      'selected': true,
    },
    'delicate': {
      'selected': false,
    },
    'offensive': {
      'selected': false,
    },
  };

  handleCategorySelectionToggle(category) => setState(() =>
      categories[category]['selected'] = !categories[category]['selected']);

  Widget categorySelection(context) {
    double svgHeight = MediaQuery.of(context).size.height * 0.16 > 72
        ? 72
        : MediaQuery.of(context).size.height * 0.16;
    double svgWidth = 65;

    return CategoriesView(
      data: svgData,
      height: svgHeight,
      elementWidth: svgWidth,
      categorySelectionChange: handleCategorySelectionToggle,
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
