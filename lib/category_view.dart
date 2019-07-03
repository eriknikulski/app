import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'category.dart';

class CategoryView extends StatelessWidget {
  CategoryView(
      {this.category, this.height, this.width, this.handleCategoryChange})
      : assert(category != null &&
            width != null &&
            height != null &&
            handleCategoryChange != null);

  final Category category;
  final double width;
  final double height;
  final Function handleCategoryChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => handleCategoryChange(category),
        child: SizedBox(
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                category.selected
                    ? category.selectedImageUri
                    : category.unselectedImageUri,
                height: height,
                width: width,
              ),
              Text(
                category.name,
                style: TextStyle(
                    fontSize: 16.0,
                    color: category.selected
                        ? Color(0xFF616161)
                        : Color(0xFF9e9e9e)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
