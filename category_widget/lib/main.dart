import 'package:category_widget/04_stateful_widget/stateful_category_route.dart';
import 'package:category_widget/05_input/input_category_route.dart';
import 'package:flutter/material.dart';

import '01_category/category_widget.dart';
import '02_category_route/category_route.dart';
import '03_navigation/navigatoin_category_route.dart';

final List<Map> entries = <Map>[
  {
    'name': 'CategoryWidget',
    'onClick': (BuildContext context, int index) {
      Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("CategoryWidget"),
            ),
            body: CategoryWidget(
                icon: Icons.cake,
                color: Colors.redAccent,
                name: 'RandallStevens'),
          );
        },
      ));
    }
  },
  {
    'name': 'CategoryRoute',
    'onClick': (BuildContext context, int index) {
      Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return CategoryRoute();
        },
      ));
    }
  },
  {
    'name': 'Navigation',
    'onClick': (BuildContext context, int index) {
      Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return NavigationCategoryRoute();
        },
      ));
    }
  },
  {
    'name': 'StatefulWidget',
    'onClick': (BuildContext context, int index) {
      Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return StatefulCategoryRoute();
        },
      ));
    }
  },
  {
    'name': 'Input',
    'onClick': (BuildContext context, int index) {
      Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return InputCategoryRoute();
        },
      ));
    }
  },
];

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: true,
        home: Scaffold(
            appBar: AppBar(
              title: Text(
                'Udacity Exercise',
                style: TextStyle(fontSize: 30),
              ),
            ),
            body: ListView.separated(
              padding: EdgeInsets.all(8.0),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  focusColor: Colors.blueGrey[900],
                  highlightColor: Colors.amber[200 + 200 * index],
                  splashColor: Colors.amber[300 + 100 * index],
                  onTap: () {
                    Function tap = entries[index]['onClick'];
                    tap(context, index);
                  },
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: 50,
                        child: Center(
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                    '${index + 1}. ${entries[index]['name']}',
                                    style: TextStyle(
                                        color: Colors.blueGrey[900],
                                        fontSize: 20)))),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(),
            ))),
  );
}
