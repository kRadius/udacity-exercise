// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:category_widget/03_navigation/unit.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';


class StatefulConverterRoute extends StatefulWidget {
  final List<Unit> units;
  final Color color;

  const StatefulConverterRoute({
    @required this.color,
    @required this.units,
  }) : assert(color != null), assert(units != null);
  @override
  State<StatefulWidget> createState() => _StatefulConverterRouteState();
}

/// Converter screen where users can input amounts to convert.
///
/// Currently, it just displays a list of mock units.
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.
class _StatefulConverterRouteState extends State<StatefulConverterRoute> {

  @override
  Widget build(BuildContext context) {
    // Here is just a placeholder for a list of mock units
    final unitWidgets = widget.units.map((Unit unit) {
      // TODO: Set the color for this Container
      return Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(16.0),
        color: widget.color,
        child: Column(
          children: <Widget>[
            Text(
              unit.name,
              style: Theme.of(context).textTheme.headline,
            ),
            Text(
              'Conversion: ${unit.conversion}',
              style: Theme.of(context).textTheme.subhead,
            ),
          ],
        ),
      );
    }).toList();

    return ListView(
      children: unitWidgets,
    );
  }
}
