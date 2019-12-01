import 'package:category_widget/01_category/category_widget.dart';
import 'package:category_widget/03_navigation/converter_route.dart';
import 'package:category_widget/03_navigation/unit.dart';
import 'package:flutter/material.dart';

final _rowHeight = 100.0;
final _borderRadius = BorderRadius.circular(_rowHeight / 2);

class NavigationCategoryWidget extends CategoryWidget {
  NavigationCategoryWidget(
      {@required IconData icon,
      @required Color color,
      @required String name,
      @required this.units})
      : assert(icon != null),
        assert(color != null),
        assert(name != null),
        assert(units != null),
        super(icon: icon, color: color, name: name);
  final List<Unit> units;

  void _onInkwellTaped(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            name,
            style: Theme.of(context).textTheme.display1,
          ),
          centerTitle: true,
          backgroundColor: color,
        ),
        body: ConverterRoute(
          color: color,
          units: units,
        ),
      );
    }));
  }

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
          onTap: () => _onInkwellTaped(context),
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
}
