import 'package:equatable/equatable.dart' show Equatable;

import 'package:never_have_i_ever/models/category.dart';
import 'package:never_have_i_ever/models/statement.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class Initialize extends AppEvent {
  final List<Category> categories;

  const Initialize(this.categories) : assert(categories.length > 0);

  @override
  List<Object> get props => [categories];

  @override
  String toString() => 'Initialize { categorie: $categories }';
}

class GoForward extends AppEvent {
  final List<Category> categories;

  const GoForward(this.categories) : assert(categories.length > 0);

  @override
  List<Object> get props => [categories];

  @override
  String toString() => 'GoForward { categorie: $categories }';
}

class AddStatement extends AppEvent {
  final Statement statement;

  const AddStatement(this.statement) : assert(statement != null);

  @override
  List<Object> get props => [statement];

  @override
  String toString() => 'AddStatement { statement: $statement }';
}

class ChangeCategory extends AppEvent {
  final List<Category> categories;

  const ChangeCategory(this.categories) : assert(categories.length > 0);

  @override
  List<Object> get props => [categories];

  @override
  String toString() => 'ChangeCategory { categorie: $categories }';
}

class HandleException extends AppEvent {
  final Exception exception;

  const HandleException(this.exception);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'HandleException { exception: $exception }';
}
