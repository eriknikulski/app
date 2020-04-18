import 'package:flutter/foundation.dart' show describeEnum;
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart' show SvgPicture;

import 'package:never_have_i_ever/models/category.dart';

class CategoryView extends StatefulWidget {
  CategoryView({this.category, this.selectionStateChanged})
      : assert(category != null && selectionStateChanged != null);

  final Category category;
  final VoidCallback selectionStateChanged;

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  double width = 65;
  double height;

  setCategoryHeight(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      // portrait
      height = MediaQuery.of(context).size.height * 0.16 > 72
          ? 72
          : MediaQuery.of(context).size.height * 0.16;
    } else {
      // landscape
      height = MediaQuery.of(context).size.width * 0.16 > 72
          ? 72
          : MediaQuery.of(context).size.width * 0.16;
    }
  }

  @override
  Widget build(BuildContext context) {
    setCategoryHeight(context);

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        setState(() => widget.category.selected = !widget.category.selected);
        widget.selectionStateChanged();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          child: Column(
            children: <Widget>[
              SvgPicture.asset(
                widget.category.selected
                    ? widget.category.selectedImageUri
                    : widget.category.unselectedImageUri,
                height: height,
                width: width,
              ),
              Text(
                describeEnum(widget.category.name),
                style: Theme.of(context).textTheme.subhead.copyWith(
                      color: widget.category.selected
                          ? Theme.of(context).textTheme.subhead.color
                          : Color(0xFF9e9e9e),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
