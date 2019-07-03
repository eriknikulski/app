import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryView extends StatelessWidget {
  /// [name] like harmless, delicate, offensive -> is actually shown
  CategoryView(
      {this.name,
      this.selected = false,
      this.selectedImageUri,
      this.unselectedImageUri,
      this.height,
      this.width,
      this.handleCategoryChange})
      : assert(name != null &&
            selectedImageUri != null &&
            unselectedImageUri != null);

  final String name;
  final String selectedImageUri;
  final String unselectedImageUri;
  final bool selected;
  final double width;
  final double height;
  final Function handleCategoryChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          handleCategoryChange(name);
          // TODO: check that not all unselected
        },
        child: SizedBox(
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                selected ? selectedImageUri : unselectedImageUri,
                height: height,
                width: width,
              ),
              Text(
                name,
                style: TextStyle(
                    fontSize: 16.0,
                    color: selected ? Color(0xFF616161) : Color(0xFF9e9e9e)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
