import 'package:flutter/material.dart';

import 'package:never_have_i_ever/blocs/statement_bloc.dart';
import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/statement.dart';
import 'package:never_have_i_ever/screens/statement_screen/widgets/categories_view.dart';
import 'package:never_have_i_ever/screens/statement_screen/widgets/statement_view.dart';

class StatementContainerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatementContainerViewState();
}

class _StatementContainerViewState extends State<StatementContainerView> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Category> categories = [
    Category(
        name: 'harmless',
        selectedImageUri: 'images/mojito.png',
        unselectedImageUri: 'images/mojito_gray.png',
        selected: true),
    Category(
        name: 'delicate',
        selectedImageUri: 'images/beer.png',
        unselectedImageUri: 'images/beer_gray.png',
        selected: false),
    Category(
        name: 'offensive',
        selectedImageUri: 'images/cocktail.png',
        unselectedImageUri: 'images/cocktail_gray.png',
        selected: false),
  ];

  Widget buildStatementView(BuildContext context) {
    return StreamBuilder(
      stream: bloc.statement,
      builder: (BuildContext context, AsyncSnapshot<Statement> snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          return StatementView(
            statement: snapshot.data,
          );
        }
        bloc.fetchStatement(categories);
        return CircularProgressIndicator();
      },
    );
  }

  @override
  void initState() {
    super.initState();
    bloc.fetchStatement(categories);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => bloc.fetchStatement(categories),
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
                    CategoriesView(categories: categories),
                    buildStatementView(context),
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
