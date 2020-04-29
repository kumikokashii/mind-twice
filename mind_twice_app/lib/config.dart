import './components/UIList.dart';
import 'package:flutter/material.dart';

final themeColor = Colors.pink[100];

Map initSetup = {
  'KEEP_DEBUG_BAR': false,
  'RESET_DATA': true,
  'LOAD_TEST_DATA': true,
  'TEST_DATA': [
    Item(null, 'Week of', DateTime(2020, 4, 20), [null, null, null, null, null],
        null, null, null),
    Item(null, 'Day of', DateTime(2020, 4, 20), [null, null, null, null, null],
        null, DateTime(2020, 4, 20), null),
    Item(null, 'Day of', DateTime(2020, 4, 21), [null, null, null, null, null],
        null, DateTime(2020, 4, 21), null),
    Item(null, 'Day of', DateTime(2020, 4, 22), [null, null, null, null, null],
        null, DateTime(2020, 4, 22), null),
    Item(null, 'Day of', DateTime(2020, 4, 23), [null, null, null, null, null],
        "Everything will work out!", DateTime(2020, 4, 23), "The story of life is quicker than the blink of an eye, the story of love is hello and goodbye... until we meet again.\n\n - Jimi Hendrix"),
    Item(null, 'Day of', DateTime(2020, 4, 24), [null, null, null, null, null],
        null, DateTime(2020, 4, 24), null),
    Item(null, 'Day of', DateTime(2020, 4, 25), [null, null, null, null, null],
        null, null, null)
  ]
};
