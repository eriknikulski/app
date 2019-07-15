import 'package:never_have_i_ever/models/category.dart';

class CategoryIcon {
  final Category name;
  final String selectedImageUri;
  final String unselectedImageUri;
  bool selected;

  CategoryIcon(
      {this.name,
      this.selectedImageUri,
      this.unselectedImageUri,
      this.selected});

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
