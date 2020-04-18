import 'package:equatable/equatable.dart';

import 'package:never_have_i_ever/models/category_icon.dart';

abstract class StatementEvent extends Equatable {
  const StatementEvent();

  @override
  List<Object> get props => [];
}

class LoadStatement extends StatementEvent {
  final List<CategoryIcon> categories;

  const LoadStatement(this.categories) : assert(categories.length > 0);

  @override
  List<Object> get props => [categories];

  @override
  String toString() => 'LoadStatement { categories: $categories }';
}
