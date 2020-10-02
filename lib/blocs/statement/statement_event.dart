import 'package:equatable/equatable.dart' show Equatable;

import 'package:nhie/models/category.dart';
import 'package:nhie/models/statement.dart';

abstract class StatementEvent extends Equatable {
  const StatementEvent();

  @override
  List<Object> get props => [];
}

class LoadStatement extends StatementEvent {
  final List<Category> categories;
  final Statement statement;

  const LoadStatement({this.categories, this.statement})
      : assert(
            (categories != null && categories.length > 0) || statement != null);

  @override
  List<Object> get props => [categories, statement];

  @override
  String toString() =>
      'LoadStatement { categories: $categories, statement: $statement }';
}
