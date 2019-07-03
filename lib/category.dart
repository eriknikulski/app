class Category {
  final String name;
  final String selectedImageUri;
  final String unselectedImageUri;
  bool selected;

  Category(
      {this.name,
      this.selectedImageUri,
      this.unselectedImageUri,
      this.selected});
}
