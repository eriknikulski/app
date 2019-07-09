import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:never_have_i_ever/models/category.dart';

class CategoryView extends StatefulWidget {
  CategoryView(
      {this.category, this.height, this.width})
      : assert(category != null &&
            width != null &&
            height != null);

  final Category category;
  final double width;
  final double height;

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          setState(() => widget.category.selected = !widget.category.selected);
        },
        child: SizedBox(
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                widget.category.selected
                    ? widget.category.selectedImageUri
                    : widget.category.unselectedImageUri,
                height: widget.height,
                width: widget.width,
              ),
              Text(
                widget.category.name,
                style: TextStyle(
                    fontSize: 16.0,
                    color: widget.category.selected
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
