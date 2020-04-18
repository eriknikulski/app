import 'package:equatable/equatable.dart' show Equatable;

import 'package:never_have_i_ever/env.dart';
import 'package:never_have_i_ever/models/statement.dart';

abstract class AppState extends Equatable {
  final Statement statement = env.defaultStatement;

  @override
  List<Object> get props => [];
}

class Uninitialized extends AppState {}

class Initialized extends AppState {}

class Forward extends AppState {
  final Statement statement;

  Forward(this.statement);

  @override
  List<Object> get props => [statement];

  @override
  String toString() {
    return 'Forward { statement: $statement }';
  }
}

class AppException extends AppState {
  final Exception exception;
  final Statement statement = env.errorStatement;

  AppException(this.exception);

  @override
  List<Object> get props => [exception];

  @override
  String toString() {
    return 'AppException { exception: $exception }';
  }
}
