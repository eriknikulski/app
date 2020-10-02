import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart' show BlocBuilder, BlocProvider;

import 'package:nhie/blocs/app/app.dart';
import 'package:nhie/env.dart';
import 'package:nhie/models/category.dart';
import 'package:nhie/screens/statement_screen/widgets/categories_view.dart';
import 'package:nhie/screens/statement_screen/widgets/statement_view.dart';

class StatementContainerView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _StatementContainerViewState();
}

class _StatementContainerViewState extends State<StatementContainerView> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Category> categories = env.categories;

  Widget buildStatementView(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if (state is Uninitialized) {
          BlocProvider.of<AppBloc>(context).add(Initialize(categories));
        }
        return StatementView(
          statement: state.statement,
        );
      },
    );
  }

  Widget buildGestureDetector() {
    return Positioned(
      top: 0,
      bottom: 0,
      left: 0,
      child: GestureDetector(
          onTap: () => BlocProvider.of<AppBloc>(context)
              .add(GoForward(categories: categories)),
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.transparent,
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool swipes = false;

    return GestureDetector(
      onPanUpdate: (details) {
        if (details.delta.dx < 0 && !swipes) {
          BlocProvider.of<AppBloc>(context)
              .add(GoForward(categories: categories));
        }
        swipes = true;
      },
      onPanEnd: (details) {
        swipes = false;
      },
      child: Stack(children: <Widget>[
        buildGestureDetector(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CategoriesView(categories: categories),
                      Container(
                        width: double.infinity,
                        child: Stack(children: [
                          Center(child: buildStatementView(context)),
                          buildGestureDetector(),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
