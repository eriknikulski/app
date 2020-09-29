import 'dart:convert' show json;

import 'package:equatable/equatable.dart' show Equatable;
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart' show required;

import 'category_name.dart';

class Statement extends Equatable {
  final String uuid;
  final String text;
  final CategoryName category;

  const Statement(
      {@required this.text, @required this.uuid, @required this.category});

  factory Statement.fromJson(String string) {
    print(string);
    final jsonData = json.decode(string);
    return Statement.fromMap(jsonData);
  }

  factory Statement.fromMap(Map map) {
    return Statement(
        uuid: map['ID'],
        text: map['statement'],
        category: CategoryName.values.firstWhere(
            (e) => e.toString() == 'CategoryName.${map['category']}'));
  }

  Map<String, dynamic> toJson() =>
    {
      'ID': uuid,
      'statement': text,
      'category': describeEnum(category),
    };

  @override
  String toString() {
    return 'Statement { uuid: $uuid, text: $text, category: $category }';
  }

  @override
  List<Object> get props => [uuid, text, category];
}
