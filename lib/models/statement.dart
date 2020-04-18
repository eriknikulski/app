import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import 'package:never_have_i_ever/models/category.dart';

class Statement extends Equatable {
  final String uuid;
  final String text;
  final Category category;

  const Statement(
      {@required this.text, @required this.uuid, @required this.category});

  factory Statement.fromJson(String string) {
    final jsonData = json.decode(string);
    return Statement.fromMap(jsonData);
  }

  factory Statement.fromMap(Map map) {
    return Statement(
        uuid: map['ID'],
        text: map['statement'],
        category: Category.values
            .firstWhere((e) => e.toString() == 'Category.${map['category']}'));
  }

  Map<String, dynamic> toJson() {
    var value = {
      'ID': uuid,
      'statement': text,
      'category': category,
    };
    return value;
  }

  @override
  String toString() {
    return 'Statement { uuid: $uuid, text: $text, category: $category }';
  }

  @override
  List<Object> get props => [uuid, text, category];
}
