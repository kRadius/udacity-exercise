// Copyright 2018 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:category_widget/03_navigation/unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

const _padding = EdgeInsets.all(16.0);

/// [ConverterRoute] where users can input amounts to convert in one [Unit]
/// and retrieve the conversion in another [Unit] for a specific [Category].
///
/// While it is named ConverterRoute, a more apt name would be ConverterScreen,
/// because it is responsible for the UI at the route's destination.
class InputConverterRoute extends StatefulWidget {
  /// Color for this [Category].
  final Color color;

  /// Units for this [Category].
  final List<Unit> units;

  /// This [ConverterRoute] requires the color and units to not be null.
  const InputConverterRoute({
    @required this.color,
    @required this.units,
  })  : assert(color != null),
        assert(units != null);

  @override
  _InputConverterRouteState createState() => _InputConverterRouteState();
}

class _InputConverterRouteState extends State<InputConverterRoute> {
  // TODO: Set some variables, such as for keeping track of the user's input
  // value and units
  double _inputValue;
  Unit _fromValue;
  Unit _toValue;
  String _convertedValue = '';
  bool _showValidationError = false;
  List<DropdownMenuItem<dynamic>> _dropdownItems;

  @override
  void initState() {
    super.initState();
    _createDropdownMenuItem();
    _setDefault();
  }

  void _createDropdownMenuItem() {
    var items = <DropdownMenuItem>[];
    for (Unit unit in widget.units) {
      DropdownMenuItem item = DropdownMenuItem(
        value: unit.name,
        child: Container(
          child: Text(
            unit.name,
            softWrap: true,
          ),
        ),
      );
      items.add(item);
    }
    setState(() {
      _dropdownItems = items;
    });
  }

  void _setDefault() {
    setState(() {
      _fromValue = widget.units.first;
      _toValue = widget.units[1];
    });
  }

  // Widget
  Widget _createDropdown(String currentValue, ValueChanged<dynamic> onChanged) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      decoration: BoxDecoration(
          color: Colors.grey[50],
          border: Border.all(color: Colors.grey[400], width: 1)),
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.grey[50]
        ),
        child: DropdownButtonHideUnderline(
          child: ButtonTheme(
            alignedDropdown: true,
            child: DropdownButton(
              value: currentValue,
              items: _dropdownItems,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.title,
            ),
          ),
        ),
      ),
    );
  }

  // Action
  void _updateConversion() {
    setState(() {
      _convertedValue = _format(_inputValue * (_toValue.conversion / _fromValue.conversion));
    });
  }
  void _updateInputValue(String value) {
      setState(() {
        if(value == null || value.isEmpty) {
          _convertedValue = '';
        } else {
          try {
            var inputDouble = double.parse(value);
            _showValidationError = false;
            _inputValue = inputDouble;
            _updateConversion();
          } on Exception catch (e) {
              _showValidationError = true;
          }
        }
      });
  }
  void _updateFromConversion(dynamic unitName) {
    setState(() {
      _fromValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }
  void _updateToConversion(dynamic unitName) {
    setState(() {
      _toValue = _getUnit(unitName);
    });
    if (_inputValue != null) {
      _updateConversion();
    }
  }
  // Help functions
  Unit _getUnit(String name) {
    return widget.units.firstWhere((Unit unit) {
      return unit.name == name;
    }, orElse: null);
  }
  /// Clean up conversion; trim trailing zeros, e.g. 5.500 -> 5.5, 10.0 -> 10
  String _format(double conversion) {
    var outputNum = conversion.toStringAsPrecision(7);
    if (outputNum.contains('.') && outputNum.endsWith('0')) {
      var i = outputNum.length - 1;
      while (outputNum[i] == '0') {
        i -= 1;
      }
      outputNum = outputNum.substring(0, i + 1);
    }
    if (outputNum.endsWith('.')) {
      return outputNum.substring(0, outputNum.length - 1);
    }
    return outputNum;
  }

  @override
  Widget build(BuildContext context) {
    // Create the 'input' group of widgets. This is a Column that
    // includes the input value, and 'from' unit [Dropdown].
    final inputGroup = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            style: Theme.of(context).textTheme.display1,
            decoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.display1,
                errorText: _showValidationError ? 'Invalid input error' : null,
                labelText: 'Input',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0.0))),
            keyboardType: TextInputType.number,
            onChanged: _updateInputValue,
          ),
          _createDropdown(_fromValue.name, _updateFromConversion)
        ],
      ),
    );
    // Create a compare arrows icon.
    final arrows = RotatedBox(
      quarterTurns: 1,
      child: Icon(
        Icons.compare_arrows,
        size: 40.0,
      ),
    );
    // Create the 'output' group of widgets. This is a Column that
    // includes the output value, and 'to' unit [Dropdown].
    final outputGroup = Padding(
      padding: _padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          InputDecorator(
            child: Text(
              _convertedValue,
              style: Theme.of(context).textTheme.display1,
            ),
            decoration: InputDecoration(
              labelText: 'Output',
              labelStyle: Theme.of(context).textTheme.display1,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0)
              )
            ),
          ),
          _createDropdown(_toValue.name, _updateToConversion)
        ],
      ),
    );
    // Return the input, arrows, and output widgets, wrapped in a Column.
    final converter = Column(
      children: <Widget>[
        inputGroup,
        arrows,
        outputGroup
      ],
    );
    return Padding(
      padding: _padding,
      child: converter,
    );
  }
}
