import 'package:equatable/equatable.dart' show Equatable;

import 'package:nhie/models/category.dart';

abstract class StatementEvent extends Equatable {
  const StatementEvent();

  @override
  List<Object> get props => [];
}

class LoadStatement extends StatementEvent {
  final List<Category> categories;

  const LoadStatement(this.categories) : assert(categories.length > 0);

  @override
  List<Object> get props => [categories];

  @override
  String toString() => 'LoadStatement { categories: $categories }';
}
