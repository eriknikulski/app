import 'package:flutter/foundation.dart' as fd;

import 'package:never_have_i_ever/models/category.dart';

class CategoryIcon {
  final Category name;
  final String selectedImageUri;
  final String unselectedImageUri;
  bool selected;

  CategoryIcon(
      {@fd.required this.name,
      @fd.required this.selectedImageUri,
      @fd.required this.unselectedImageUri,
      @fd.required this.selected});

  @override
  String toString() {
    return 'Category: {'
        'name: $name, '
        'selectedImageUri: $selectedImageUri, '
        'unselectedImageUri: $unselectedImageUri, '
        'selected: $selected'
        '}';
  }
}
