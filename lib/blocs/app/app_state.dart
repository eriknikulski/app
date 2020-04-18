import 'package:equatable/equatable.dart';

import 'package:never_have_i_ever/models/statement.dart';

abstract class AppState extends Equatable {
  final statement;

  // TODO: fetch default statement from config
  const AppState(
      {this.statement = const Statement(
          text: 'Tap to start playing', uuid: null, category: null)});

  @override
  List<Object> get props => [];
}

class Uninitialized extends AppState {}

class Initialized extends AppState {}

class Forward extends AppState {
  final Statement statement;

  const Forward(this.statement);

  @override
  List<Object> get props => [statement];

  @override
  String toString() {
    return 'Forward { statement: $statement }';
  }
}

class Backward extends AppState {
  final Statement statement;

  const Backward(this.statement);

  @override
  List<Object> get props => [statement];

  @override
  String toString() {
    return 'Backward { statement: $statement }';
  }
}

class AppException extends AppState {
  final Exception exception;
  final Statement statement;

  const AppException(this.exception,
      {this.statement = const Statement(
          text: 'No internet connection',
          uuid: null,
          category:
              null)}); // TODO: might change this to a more general message i.e. "Statement couldn't be loaded"

  @override
  List<Object> get props => [exception];

  @override
  String toString() {
    return 'AppException { exception: $exception }';
  }
}
