import 'dart:convert';

class Statement {
  final String text;

  const Statement({this.text});

  factory Statement.fromJson(String string) {
    final jsonData = json.decode(string);
    return Statement(text: jsonData['statement']);
  }

  String toJson() => json.encode({
        "statement": text,
      });

  @override
  String toString() {
    return 'Statement: {text: $text}';
  }
}
