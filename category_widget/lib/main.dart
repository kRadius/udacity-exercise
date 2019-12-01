import 'package:category_widget/category_widget.dart';
import 'package:flutter/material.dart';

//class CategoryWidget extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Center(
//        child: CategoryWidget(
//            icon: Icons.cake, color: Colors.redAccent, name: 'RandallStevens'));
//  }
//}

final List<Map> entries = <Map>[
  {
    'name': 'CategoryWidget',
    'onClick': (BuildContext context, int index) {
      Navigator.push(context, MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(title: Text(entries[index]['name'])),
            body: Center(
              child: CategoryWidget(
                  icon: Icons.cake,
                  color: Colors.redAccent,
                  name: 'RandallStevens'),
            ),
          );
        },
      ));
    }
  },
  {
    'name': 'CategoryRoute',
    'onClick': (BuildContext context) {
      print('click');
    }
  },
];

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: true,
        home: Scaffold(
            appBar: AppBar(
              title: Text('Udacity Exercise', style: TextStyle(fontSize: 30),),
            ),
            body: ListView.separated(
              padding: EdgeInsets.all(8.0),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  highlightColor: Colors.amber[200 + 100 * index],
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
                                    style:
                                        Theme.of(context).textTheme.headline))),
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
