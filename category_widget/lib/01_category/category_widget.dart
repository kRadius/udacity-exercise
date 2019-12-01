//The icon, color, and text should be passed into the Category widget upon instantiation. They should be required.
//Height of the Category widget is 100.0. Its padding is 8.0.
//The widget's border radius is half of the Category height (in this case, 50.0). You can define both the height and the border radius as constants.
//Icon size is 60.0. The padding around the icon is 16.0.
//Text size is 24.0.
//The InkWell will not animate if the onTap function is null. Use a print statement for now, as a placeholder. i.e. onTap: () { print('I was tapped!'); }.
//The InkWell's splash and highlight colors should be the color we pass in.

import 'package:category_widget/03_navigation/unit.dart';
import 'package:flutter/material.dart';

final _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class CategoryWidget extends StatelessWidget {
  const CategoryWidget(
      {Key key, @required this.icon, @required this.color, @required this.name})
      : assert(icon != null),
        assert(color != null),
        assert(name != null),
        super(key: key);

  final IconData icon;
  final Color color;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Material(
          color: Colors.transparent,
          child: Container(
            height: _rowHeight,
            child: InkWell(
              borderRadius: _borderRadius,
              highlightColor: this.color,
              splashColor: this.color,
              onTap: _onInkwellTaped,
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(this.icon, size: 60),
                  ),
                  Center(
                    child: Text(
                      this.name,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }

  //Action
  void _onInkwellTaped() {
    print('I was tapped');
  }
}
