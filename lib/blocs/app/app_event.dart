import 'package:equatable/equatable.dart' show Equatable;

import 'package:nhie/models/category.dart';
import 'package:nhie/models/statement.dart';

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
  String toString() => 'Initialize { categories: $categories }';
}

class GoForward extends AppEvent {
  final List<Category> categories;
  final Statement statement;

  const GoForward({this.categories, this.statement})
      : assert(
            (categories != null && categories.length > 0) || statement != null);

  @override
  List<Object> get props => [categories, statement];

  @override
  String toString() =>
      'GoForward { categories: $categories, statement: $statement }';
}

class AddStatement extends AppEvent {
  final Statement statement;

  const AddStatement(this.statement) : assert(statement != null);

  @override
  List<Object> get props => [statement];

  @override
  String toString() => 'AddStatement { statement: $statement }';
}

class ChangeCategories extends AppEvent {
  final List<Category> categories;

  const ChangeCategories(this.categories) : assert(categories.length > 0);

  @override
  List<Object> get props => [categories];

  @override
  String toString() => 'ChangeCategories { categories: $categories }';
}

class ChangeLanguage extends AppEvent {
  final String language;

  const ChangeLanguage(this.language) : assert(language != null);

  @override
  List<Object> get props => [language];

  @override
  String toString() => 'ChangeLanguage { language: $language }';
}

class HandleException extends AppEvent {
  final Exception exception;

  const HandleException(this.exception);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'HandleException { exception: $exception }';
}
