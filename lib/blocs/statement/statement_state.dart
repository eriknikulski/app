import 'package:equatable/equatable.dart' show Equatable;

import 'package:nhie/models/statement.dart';

abstract class StatementState extends Equatable {
  const StatementState();

  @override
  List<Object> get props => [];
}

class StatementLoading extends StatementState {}

class StatementLoaded extends StatementState {
  final Statement statement;

  const StatementLoaded(this.statement);

  @override
  List<Object> get props => [statement];

  @override
  String toString() => 'StatementLoaded { statement: $statement }';
}

class StatementNotLoaded extends StatementState {
  final Exception exception;

  const StatementNotLoaded(this.exception);

  @override
  List<Object> get props => [exception];

  @override
  String toString() => 'StatementNotLoaded { exception: $exception }';
}
