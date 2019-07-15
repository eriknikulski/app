import 'dart:convert';

import 'package:quiver/core.dart';

import 'package:never_have_i_ever/models/category.dart';

class Statement {
  final String uuid;
  final String text;
  final Category category;

  const Statement({this.text, this.uuid, this.category});

  factory Statement.fromJson(String string) {
    final jsonData = json.decode(string);
    return Statement(
        uuid: jsonData['ID'],
        text: jsonData['statement'],
        category: Category.values.firstWhere(
            (e) => e.toString() == 'Category.${jsonData['category']}'));
  }

  String toJson() => json.encode({
        "statement": text,
      });

  @override
  String toString() {
    return 'Statement: {text: $text}';
  }

  @override
  bool operator ==(other) {
    if (other is! Statement) {
      return false;
    }

    if (hashCode != other.hashCode) {
      return false;
    }

    return true;
  }

  @override
  int get hashCode => hash3(uuid, text, category);
}
