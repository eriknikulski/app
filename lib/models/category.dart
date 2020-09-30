import 'package:meta/meta.dart' show required;

import 'package:nhie/models/category_name.dart';

class Category {
  final CategoryName name;
  final String selectedImageUri;
  final String unselectedImageUri;
  bool selected;

  Category(
      {@required this.name,
      @required this.selectedImageUri,
      @required this.unselectedImageUri,
      @required this.selected});

  factory Category.fromMap(Map map) {
    return Category(
        name: CategoryName.values
            .firstWhere((e) => e.toString() == 'CategoryName.${map['name']}'),
        selectedImageUri: map['selectedImageUri'],
        unselectedImageUri: map['unselectedImageUri'],
        selected: map['selected']);
  }

  @override
  String toString() {
    return 'Category { '
        'name: $name, '
        'selectedImageUri: $selectedImageUri, '
        'unselectedImageUri: $unselectedImageUri, '
        'selected: $selected'
        ' }';
  }
}
