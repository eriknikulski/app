import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'utils.dart';

class StatementView extends StatefulWidget {
  StatementView({this.text}) : assert(text != null);

  final String text;

  @override
  _StatementViewState createState() => _StatementViewState();
}

class _StatementViewState extends State<StatementView> {
  Map<String, Map<String, dynamic>> svgUris = {
    'mojito': {
      'type': 'harmless',
      'images': {
        true: 'images/mojito.svg',
        false: 'images/mojito_gray.svg'
      },
      'selected': true
    },
    'beer': {
      'type': 'delicate',
      'images': {
        true: 'images/beer.svg',
        false: 'images/beer_gray.svg'
      },
      'selected': false
    },
    'cocktail': {
      'type': 'offensive',
      'images': {
        true: 'images/cocktail.svg',
        false: 'images/cocktail_gray.svg'
      },
      'selected': false
    },
  };

  Widget _categorySelection(context) {
    double svgHeight = MediaQuery.of(context).size.height * 0.16 > 72
        ? 72
        : MediaQuery.of(context).size.height * 0.16;
    double svgWidth = 65;

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: svgUris.keys.map(
          (key) {
            var selected = svgUris[key]['selected'];
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () =>
                    setState(() => svgUris[key]['selected'] = !selected),
                child: SizedBox(
//                width: svgWidth,
                  child: Column(
                    children: <Widget>[
                      SvgPicture.asset(
                        svgUris[key]['images'][selected],
                        height: svgHeight,
                        width: svgWidth,
                        semanticsLabel: capitalize(key),
                      ),
                      Text(
                        svgUris[key]['type'],
                        style: TextStyle(
                            color: selected
                                ? Color(0xFF616161)
                                : Color(0xFF9e9e9e)),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _categorySelection(context),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.text,
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 36.0, color: Color(0xFF424242)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
