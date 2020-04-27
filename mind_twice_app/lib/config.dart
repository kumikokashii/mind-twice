import './components/UIList.dart';
import 'package:flutter/material.dart';

final themeColor = Colors.pink[100];

Map initSetup = {
  'RESET_DATA': false,
  'LOAD_TEST_DATA': true,
  'TEST_DATA': [
    Item(
        null,
        'Lalala Long title long title long title..............................',
        DateTime.now(),
        [null, null, null, null, null],
        null,
        null,
        null),
    Item(null, 'Saturn x Pluto', DateTime(2020, 1, 12),
        [null, null, null, null, null], null, DateTime(2020, 9, 12), null),
    Item(null, 'Hello-', DateTime(2003, 4, 5), [null, null, null, null, null],
        null, null, null)
  ]
};
