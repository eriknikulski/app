import 'package:meta/meta.dart';

import 'package:never_have_i_ever/models/category.dart';

class CategoryIcon {
  final Category name;
  final String selectedImageUri;
  final String unselectedImageUri;
  bool selected;

  CategoryIcon(
      {@required this.name,
      @required this.selectedImageUri,
      @required this.unselectedImageUri,
      @required this.selected});

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
