import 'package:category_widget/03_navigation/unit.dart';
import 'package:category_widget/04_stateful_widget/stateful_category_widget.dart';
import 'package:flutter/material.dart';

final _backgroundColor = Colors.green[100];

/// Category Route (screen).
///
/// This is the 'home' screen of the Unit Converter. It shows a header and
/// a list of [Categories].
///
/// While it is named CategoryRoute, a more apt name would be CategoryScreen,
/// because it is responsible for the UI at the route's destination.
class StatefulCategoryRoute extends StatefulWidget {
  const StatefulCategoryRoute();

  @override
  State<StatefulWidget> createState() => _StatefulCategoryRouteState();
} // end StatefulCategoryRoute

class _StatefulCategoryRouteState extends State<StatefulCategoryRoute> {
  final _categories = <Widget>[];

  static const _categoryNames = <String>[
    'Length',
    'Area',
    'Volume',
    'Mass',
    'Time',
    'Digital Storage',
    'Energy',
    'Currency',
  ];

  static const _baseColors = <Color>[
    Colors.teal,
    Colors.orange,
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.yellow,
    Colors.greenAccent,
    Colors.purpleAccent,
    Colors.red,
  ];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _categoryNames.length; i++) {
      _categories.add(
        StatefulCategoryWidget(
          color: _baseColors[i],
          icon: Icons.cake,
          name: _categoryNames[i],
          units: _retrieveUnits(_categoryNames[i]),
        ),
      );
    }
  }

  Widget _buildCategoriesWidget() {
    return ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Container(
            height: 80,
            child: _categories[index],
          );
        },
        itemCount: _categories.length);
  }

  List<Unit> _retrieveUnits(String name) {
    return List.generate(10, (int i) {
      i = i + 1;
      return Unit(name: name, conversion: i.toDouble());
    });
  }

  @override
  Widget build(BuildContext context) {
    final listView = Container(
      color: _backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      child: _buildCategoriesWidget()
    );

    final appBar = AppBar(
      elevation: 10.0,
      title: Text(
        'Unit Converter',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30.0,
        ),
      ),
      centerTitle: true,
      backgroundColor: _backgroundColor,
    );

    return Scaffold(
      appBar: appBar,
      body: listView,
    );
  }
}
