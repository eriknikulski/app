import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:never_have_i_ever/models/category_icon.dart';

class CategoryView extends StatefulWidget {
  CategoryView({this.category, this.selectionStateChanged})
      : assert(category != null && selectionStateChanged != null);

  final CategoryIcon category;
  final VoidCallback selectionStateChanged;

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  Image selectedImage;
  Image unselectedImage;
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
  void initState() {
    super.initState();

    selectedImage = Image.asset(
      widget.category.selectedImageUri,
    );
    unselectedImage = Image.asset(
      widget.category.unselectedImageUri,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precacheImage(selectedImage.image, context);
    precacheImage(unselectedImage.image, context);
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
              Image.asset(
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
