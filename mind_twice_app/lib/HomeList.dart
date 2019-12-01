import 'package:flutter/material.dart';
import './ItemScreen.dart';
// import './DatabaseHelper.dart';


class HomeList extends StatefulWidget {
  HomeList();

  @override
  _HomeListState createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  _HomeListState();
  // DatabaseHelper dbHelper = DatabaseHelper.instance; //Create this singleton

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('List!'),
      RaisedButton(
          child: Text('To its own screen'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ItemScreen()),
            );
          })
    ]);
  }
}
